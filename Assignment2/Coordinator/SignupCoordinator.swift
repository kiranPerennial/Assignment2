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
        signupViewController.viewModel = viewModel
        viewModel.showLogin.asObservable().subscribe(onNext:{ _ in
                self.showLogin()
            }).disposed(by: disposeBag)
        viewModel.showError.subscribe(onNext: { [weak self] in self?.showErrorAlert(errorMessage: $0)}).disposed(by: disposeBag)
        return signupViewController
    }
}

extension SignUpCoordinator {
    func showLogin() {
        self.rootViewController.popViewController(animated: true)
    }
    
    func showErrorAlert(errorMessage: String) {
        signupViewController.showAlert(title: "My Calendar", message: errorMessage)
    }
}
