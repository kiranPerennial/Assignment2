//
//  SignUpViewModel.swift
//  CalendarApp-MVVM
//


import Foundation
import RxSwift
class SignUpViewModel {
//    private var user:Signup?
//    private let minPasswordCharacters = 6
//    let showLogin = PublishSubject<Void>()
//    let firstNameSubject = PublishSubject<String>()
//    let lastNameSubject = PublishSubject<String>()
//    let emailSubject = PublishSubject<String>()
//    let passwordSubject = PublishSubject<String>()
//    let confirmPasswordSubject = PublishSubject<String>()
//
//
//    var isValidForm: Observable<Bool> {
//        return Observable.combineLatest(firstNameSubject, lastNameSubject, emailSubject, passwordSubject, confirmPasswordSubject) {[weak self] fName, lName, email, password, confirmPassword in
//            let pass = password.trimmingCharacters(in: .whitespacesAndNewlines)
//            let confirmpas = password.trimmingCharacters(in: .whitespacesAndNewlines)
//            let passwordStatus = pass.count >= (self?.minPasswordCharacters ?? 0) && confirmpas.count >= (self?.minPasswordCharacters ?? 0) && pass == confirmpas
//            let fname = fName.trimmingCharacters(in: .whitespacesAndNewlines)
//            let lname = lName.trimmingCharacters(in: .whitespacesAndNewlines)
//            let nameStatus = fname.count >= 4 && lname.count >= 4
//            self?.user = Signup(firstName: fName, lastName: lName, email: email, password: password)
//            return nameStatus && email.isValidEmail() && passwordStatus
//        }
//    }
//
//    func didTapOnSignup() {
//        if let user = self.user {
//        UserManager().saveNewUser(user: user)
//            showLogin.onNext(Void())
//        }
//    }
}
