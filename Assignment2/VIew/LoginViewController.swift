import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel:LoginViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.view.endEditing(true)
    }
    
    func setupBinding() {
        self.navigationController?.navigationBar.isHidden = true
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        viewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginButton.rx.tap
            .bind { [weak self] in self?.viewModel?.didTapLogin()}
            .disposed(by: disposeBag)
        signupButton.rx.tap
            .bind(to: viewModel.showSignUp).disposed(by: disposeBag)
    }
}
