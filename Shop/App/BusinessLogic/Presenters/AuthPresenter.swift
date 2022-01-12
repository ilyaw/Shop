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
    func showMainTabbar()
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
    
    weak var viewInput: (UIViewController & AuthViewInput)?
    
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
                DispatchQueue.main.async {
                    guard let user = login.user else {
                        self.viewInput?.showError(error: "Ошибка в авторизации")
                        return
                    }
                    AppData.accessToken = user.accessToken
                    AppData.username = user.fullName
                    
                    self.viewInput?.showMainTabbar()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if let statusCode = response.response?.statusCode,
                       statusCode == 401 {
                        self.viewInput?.showError(error: "Неверный логин или пароль")
                    } else {
                        self.viewInput?.showError(error: error.localizedDescription)
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func showActivityIndicator(isShow: Bool) {
        isShow ? viewInput?.activityIndicatorView.startAnimating() :   viewInput?.activityIndicatorView.stopAnimating()
    }
    
    @objc private func keyboardWasShown(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardFrameValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let kbSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        viewInput?.scrollView.contentInset = contentInsets
        viewInput?.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        viewInput?.scrollView.contentInset = contentInsets
    }
    
    @objc private func hideKeyboard() {
        viewInput?.scrollView.endEditing(true)
    }
    
    private func checkDataValid() -> Bool {
        guard let loginTextField = viewInput?.loginTextField,
              let passwordTextField = viewInput?.passwordTextField,
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
              let login = viewInput?.loginTextField.text,
              let password = viewInput?.passwordTextField.text else { return }
        
        showActivityIndicator(isShow: true)
        
        requestAuth(userName: login, password: password) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
    
    @objc private func didTapSignUp() {
        router.showSignUp()
//        let registerController = SignUpBuilder.build()
//        viewInput?.showRegisterController(to: registerController)
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
        viewInput?.scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func addTargerForSignInButton() {
        viewInput?.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    func addTargetForSignUpButton() {
        viewInput?.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
}
