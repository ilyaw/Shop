//
//  AuthPresenter.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import UIKit

protocol MainViewInput {
    var requestFactory: RequestFactory { get }
    var activityIndicatorView: UIActivityIndicatorView { get }
    func showError(error: Error)
    func showLoginResult(result: LoginResult)
    func showLogoutResult(result: LogoutResult)
}

protocol MainViewOutput {
    func auth(userName: String, password: String)
    func logout(userId: Int)
}

class AuthPresenter {
    
    // MARK: - Public properties
    
    weak var viewInput: (UIViewController & MainViewInput)?
    
    // MARK: - Private properties
    
    private var authRequestFactory: AuthRequestFactory? {
        viewInput?.requestFactory.makeAuthRequestFatory()
    }
    
    // MARK: - Private properties
    
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
}

// MARK: - AuthPresenter + MainViewOutput

extension AuthPresenter: MainViewOutput {
    
    // MARK: - Public methods
    
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
