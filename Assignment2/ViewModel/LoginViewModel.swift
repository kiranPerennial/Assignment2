import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    var user: User?
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let showHome = PublishSubject<User>()
    let showSignUp = PublishSubject<Void>()
    let showError = PublishSubject<String>()
    
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailSubject, passwordSubject) {email, password in
            
            let status = email.isValidEmail() && password.isValidPassword()
            self.user = User(email: email, password: password)
            return status
        }
    }

    func didTapLogin() {
        if let user = self.user {
            if let allUser = ServiceRequest.retrieve("CalenderUsers.json", as: [User].self) {
                let user = allUser.filter{ $0.email == user.email && $0.password == user.password }
                if user.count > 0 {
                    self.showHome.onNext(user[0])
                } else {
                    self.showError.onNext("Please Enter Valid Email and Password")
                }
            }
        }
    }
    
    func didtapSignup() {
        showSignUp.onNext(Void())
    }
}
