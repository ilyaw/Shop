//
//  AuthPresenter.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

protocol MainViewInput: AnyObject {
    var requestFactory: RequestFactory { get }
    var scrollView: UIScrollView { get }
    var activityIndicatorView: UIActivityIndicatorView { get }
    
    func showError(error: Error)
    func showLoginResult(result: LoginResult)
    func showLogoutResult(result: LogoutResult)
}

protocol MainViewOutput: AnyObject {
    func auth(userName: String, password: String)
    func logout(userId: Int)
    
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func addTapGestureForHideKeybaord()
}

class AuthPresenter {
    
    // MARK: - Public properties
    
    weak var viewInput: (UIViewController & MainViewInput)?
    
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
                    self.viewInput?.showLoginResult(result: login)
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
    
    private func requestLogout(userId: Int) {
        authRequestFactory?.logout(userId: userId, completionHandler: { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let logout):
                DispatchQueue.main.async {
                    self.viewInput?.showLogoutResult(result: logout)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewInput?.showError(error: error)
                }
            }
        })
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
}

// MARK: - AuthPresenter + MainViewOutput

extension AuthPresenter: MainViewOutput {
    
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
    
    func auth(userName: String, password: String) {
        showActivityIndicator(isShow: true)
        
        requestAuth(userName: userName, password: password) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
    
    func logout(userId: Int) {
        requestLogout(userId: userId)
    }
}
