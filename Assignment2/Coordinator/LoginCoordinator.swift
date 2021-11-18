import Foundation
import UIKit
import RxSwift

class LoginCoordinator: Coordinator, StoryboardInitializable {
    var calendarCoordinator : CalendarCoordinator!
    var signUpCoordinator : SignUpCoordinator!
    var rootViewController: UINavigationController!
    var loginViewController:LoginViewController!
    let disposeBag = DisposeBag()
    
    func start() -> UIViewController{
        loginViewController = LoginCoordinator.instantiateViewController(storyboardName: .Main, identifier: LoginViewController.storyboardIdentifier) as? LoginViewController
        let viewModel = LoginViewModel()
        loginViewController.viewModel = viewModel
        viewModel.showHome.asObservable().subscribe(onNext:{ user in
                self.showHome(user: user)
            }).disposed(by: disposeBag)
        viewModel.showSignUp.asObservable().subscribe(onNext:{ _ in
                self.showSignUp()
            }).disposed(by: disposeBag)
        viewModel.showError.subscribe(onNext: { [weak self] in self?.showErrorAlert(errorMessage: $0)}).disposed(by: disposeBag)
        return loginViewController
    }
}

extension LoginCoordinator {
    func showHome(user: User) {
        calendarCoordinator = CalendarCoordinator()
        calendarCoordinator.rootViewController = rootViewController
        let viewController = calendarCoordinator.start()
        let calendarVC = viewController as? CalenderViewController
        calendarVC?.viewModel.user = user
        self.rootViewController.pushViewController(calendarVC!, animated: true)
    }
    
    func showSignUp() {
        signUpCoordinator = SignUpCoordinator()
        signUpCoordinator.rootViewController = rootViewController
        let signUpVC = signUpCoordinator.start()
        self.rootViewController.pushViewController(signUpVC, animated: true)
    }
    
    func showErrorAlert(errorMessage: String) {
        loginViewController.showAlert(title: "My Calendar", message: errorMessage)
    }
    
}

