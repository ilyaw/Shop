//
//  SignUpViewController.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit
import SPAlert

class SignUpViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let presenter: SignUpViewOutput

    // MARK: - Inits
    
    init(presenter: SignUpViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.configureController()
        setupDelegates()
    }
    
    override func loadView() {
        view = SignUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.addObserverForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.removeObserverForKeyboardNotification()
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        signUpView.loginTextField.delegate = self
        signUpView.nameTextField.delegate = self
        signUpView.phoneNumberTextField.delegate = self
        signUpView.cardTextField.delegate = self
        signUpView.passwordTextField.delegate = self
    }
}

// MARK: - SignUpViewController + SignUpViewInput

extension SignUpViewController: SignUpViewInput {
        
    // MARK: - Public properties
    
    var signUpView: SignUpView {
        return (view as? SignUpView) ?? SignUpView()
    }
    
    // MARK: - Public methods
    
    func showError(error: String) {
        SPAlert.present(message: error, haptic: .error)
    }
}

// MARK: - SignUpViewController + UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let result = presenter.textField(textField,
                                         shouldChangeCharactersIn: range,
                                         replacementString: string)
        
        return result
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUpView.loginTextField.resignFirstResponder()
        signUpView.nameTextField.resignFirstResponder()
        signUpView.phoneNumberTextField.resignFirstResponder()
        signUpView.cardTextField.resignFirstResponder()
        signUpView.passwordTextField.resignFirstResponder()
        return true
    }
}
