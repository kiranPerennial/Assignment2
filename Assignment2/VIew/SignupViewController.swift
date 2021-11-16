//
//  SignupViewController.swift
//  Assignment2
//
//  Created by APPLE on 15/11/21.
//

import UIKit
import RxSwift

class SignupViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var viewModel: SignUpViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.signupButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.view.endEditing(true)
    }
    
    func setupBinding() {
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        viewModel.isValidForm.bind(to: signupButton.rx.isEnabled).disposed(by: disposeBag)
        signupButton.rx.tap
            .bind { [weak self] in self?.viewModel?.didTapOnSignup()}
            .disposed(by: disposeBag)
    }
}
