import Foundation
import RxSwift

class SignUpViewModel {
    var user: User?
    let showLogin = PublishSubject<Void>()
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let showError = PublishSubject<String>()

    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailSubject, passwordSubject) {[weak self] email, password in
            self?.user = User(email: email, password: password)
            return email.isValidEmail() && password.isValidPassword()
        }
    }

    func didTapOnSignup() {
        if let user = self.user {
            if let allUser = ServiceRequest.retrieve("CalenderUsers.json", as: [User].self) {
                let users = allUser.filter{ $0.email == user.email }
                if users.count > 0 {
                    self.showError.onNext("Please Enter Valid Email and Password")
                } else {
                    ServiceRequest.store(user, as: "CalenderUsers.json")
                    self.showLogin.onNext(Void())
                }
            }
        }
    }
}
