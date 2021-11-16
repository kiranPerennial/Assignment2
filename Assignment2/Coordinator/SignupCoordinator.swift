//
//  SignupCoordinator.swift
//  CalendarApp-MVVM
//


import Foundation
import Foundation
import UIKit
import RxSwift

class SignUpCoordinator: Coordinator, StoryboardInitializable {
    var rootViewController:UINavigationController!
    var signupViewController:SignupViewController!
    let disposeBag = DisposeBag()
    func start()->UIViewController{
        signupViewController = SignUpCoordinator.instantiateViewController(storyboardName: .Main, identifier: SignupViewController.storyboardIdentifier) as? SignupViewController
        let viewModel = SignUpViewModel()
//        signupViewController.viewModel = viewModel
//        viewModel.showLogin.asObservable().subscribe(onNext:{ _ in
//                self.showLogin()
//            }).disposed(by: disposeBag)
        return signupViewController
    }
}

extension SignUpCoordinator {
    func showLogin() {
        self.rootViewController.popViewController(animated: true)
    }
}

