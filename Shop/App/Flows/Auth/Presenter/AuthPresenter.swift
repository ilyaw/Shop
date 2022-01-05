//
//  AuthPresenter.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit
import SwiftKeychainWrapper

protocol AuthViewInput: AnyObject {
    var requestFactory: RequestFactory { get }
    var scrollView: UIScrollView { get }
    var activityIndicatorView: UIActivityIndicatorView { get }
    var signInButton: UIButton { get }
    var loginTextField: OneLineTextField { get }
    var passwordTextField: OneLineTextField { get }
    
    func showError(error: Error)
    //    func showLoginResult(result: LoginResult)
    //    func showLogoutResult(result: LogoutResult)
}

protocol AuthViewOutput: AnyObject {
    //    func auth(userName: String, password: String)
    //    func logout(userId: Int)
    
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func addTapGestureForHideKeybaord()
    func addTargerForSignInButton()
}

class AuthPresenter {
    
    // MARK: - Public properties
    
    weak var viewInput: (UIViewController & AuthViewInput)?
    
    // MARK: - Private properties
    
    private var authRequestFactory: AuthRequestFactory? {
        viewInput?.requestFactory.makeAuthRequestFatory()
    }
    
    // MARK: - Private methods
    
    private func requestAuth(userName: String, password: String, completion: @escaping () -> Void) {
        authRequestFactory?.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let login):
                DispatchQueue.main.async {
                    AppData.accessToken = login.user.accessToken
                    AppData.username = login.user.firstName
                    
                    let mainTabbar = MainTabBar()
                    UIApplication.setRootVC(viewController: mainTabbar)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewInput?.showError(error: error)
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
}
