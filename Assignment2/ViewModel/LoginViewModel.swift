//
//  LoginViewModel.swift
//  CalendarApp-MVVM
//

import Foundation
import RxSwift
import RxCocoa

enum loginMessage:String {
    case validUser
    case invalidUser = "Please signup to continue"
    case invalidCredential = "Please enter valid Id & Password"
}

class LoginViewModel {
    var user: Login?
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let showHome = PublishSubject<Void>()
    let showSignUp = PublishSubject<Void>()
    let showError = PublishSubject<loginMessage>()

//    var isActiveSignIn: Bool {
//        if UserManager().getCurrentUser() != nil {
//            return true
//        }
//        return false
//    }
    var isValidForm: Observable<Bool> {
        return Observable.combineLatest(emailSubject, passwordSubject) {email, password in
            
            let status = email.isValidEmail() && password.isValidPassword()
            self.user = Login(email: email, password: password)
            return status
        }
    }

    func didTapLogin() {
        if let user = self.user {
//            let loginMessage = UserManager().saveCurrentUser(user: user)
//            if loginMessage == .validUser {
//                self.showHome.onNext(Void())
//            } else {
//                self.showError.onNext(loginMessage)
//            }
            self.showHome.onNext(Void())
        }
    }
}
