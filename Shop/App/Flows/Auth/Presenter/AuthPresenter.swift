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
    func showResult(result: LoginResult)
}

protocol MainViewOutput {
    func auth(userName: String, password: String)
}

class AuthPresenter {
    weak var viewInput: (UIViewController & MainViewInput)?
    
    private func requestAuth(userName: String,
                             password: String,
                             completion: @escaping () -> Void) {
        let auth = viewInput?.requestFactory.makeAuthRequestFatory()
        auth?.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.viewInput?.showResult(result: login)
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
}

extension AuthPresenter: MainViewOutput {
    func auth(userName: String, password: String) {
        showActivityIndicator(isShow: true)
        
        requestAuth(userName: userName, password: password) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
}
