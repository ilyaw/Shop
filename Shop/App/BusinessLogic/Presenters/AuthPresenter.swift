//
//  AuthPresenter.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

protocol AuthViewInput: AnyObject {
    var scrollView: UIScrollView { get }
    var activityIndicatorView: UIActivityIndicatorView { get }
    var signInButton: UIButton { get }
    var signUpButton: UIButton { get }
    var loginTextField: OneLineTextField { get }
    var passwordTextField: OneLineTextField { get }
    
    func showError(error: String)
    func showRegisterController(to controller: UIViewController)
}

protocol AuthViewOutput: AnyObject {
    init(router: StartRouter, requestFactory: AuthRequestFactory)
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func addTapGestureForHideKeybaord()
    func addTargerForSignInButton()
    func addTargetForSignUpButton()
}

class AuthPresenter {
    
    // MARK: - Public properties
    
    weak var input: (UIViewController & AuthViewInput)?
    
    let router: StartRouter
    let requestFactory: AuthRequestFactory
    
    // MARK: - Inits
    
    required init(router: StartRouter, requestFactory: AuthRequestFactory) {
        self.router = router
        self.requestFactory = requestFactory
    }
    
    // MARK: - Private methods
    
    private func requestAuth(userName: String, password: String, completion: @escaping () -> Void) {
        requestFactory.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let login):
                guard let user = login.user else {
                    DispatchQueue.main.async {
                        self.input?.showError(error: "Ошибка в авторизации")
                    }
                    return
                }
                
                AppData.accessToken = user.accessToken
                AppData.fullName = user.fullName
                
                DispatchQueue.main.async {
                    self.router.onShowMainScreen?()
                }
            case .failure(let error):
                logging(error.localizedDescription)
                
                if let statusCode = response.response?.statusCode,
                   statusCode == 401 {
                    DispatchQueue.main.async {
                        self.input?.showError(error: "Неверный логин или пароль")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.input?.showError(error: error.localizedDescription)
                    }
                }
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func showActivityIndicator(isShow: Bool) {
        guard let view = input else { return }
        isShow ? view.activityIndicatorView.startAnimating() : view.activityIndicatorView.stopAnimating()
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardFrameValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let kbSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        input?.scrollView.contentInset = contentInsets
        input?.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        input?.scrollView.contentInset = contentInsets
    }
    
    @objc private func hideKeyboard() {
        input?.scrollView.endEditing(true)
    }
    
    private func checkDataValid() -> Bool {
        guard let loginTextField = input?.loginTextField,
              let passwordTextField = input?.passwordTextField,
              let login = loginTextField.text,
              let password = passwordTextField.text else {
                  return false
              }
        
        if login.isEmpty && password.isEmpty {
            loginTextField.shake()
            passwordTextField.shake()
            return false
        } else if login.isEmpty {
            loginTextField.shake()
            return false
        } else if password.isEmpty {
            passwordTextField.shake()
            return false
        }
        
        return true
    }
    
    @objc private func didTapSignIn() {
        guard checkDataValid(),
              let login = input?.loginTextField.text,
              let password = input?.passwordTextField.text else { return }
        
        showActivityIndicator(isShow: true)
        
        requestAuth(userName: login, password: password) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
    
    @objc private func didTapSignUp() {
        router.showSignUp()
    }
    
    deinit {
        print("deinit AuthPresenter")
    }
}

// MARK: - AuthPresenter + AuthViewOutput

extension AuthPresenter: AuthViewOutput {
    
    // MARK: - Public methods
    
    func addObserverForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserverForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func addTapGestureForHideKeybaord() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        input?.scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func addTargerForSignInButton() {
        input?.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    func addTargetForSignUpButton() {
        input?.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
}
