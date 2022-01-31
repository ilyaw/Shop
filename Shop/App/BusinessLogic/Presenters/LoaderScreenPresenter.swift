//
//  LoaderScreenPresenter.swift
//  Shop
//
//  Created by Ilya on 23.01.2022.
//

import UIKit

protocol LoaderScreenViewInput: AnyObject {
    var loaderScreenView: LoaderScreenView { get }
}

protocol LoaderScreenViewOutput: AnyObject {
    init(router: StartRouter, requestFactory: AuthRequestFactory)
    func setup()
}

class LoaderScreenPresenter {
    
    // MARK: - Public properties
    
    weak var input: (UIViewController & LoaderScreenViewInput)?
    
    // MARK: - Private properties
    
    private let router: StartRouter
    private let requestFactory: AuthRequestFactory
    
    // MARK: - Inits
    
    required init(router: StartRouter, requestFactory: AuthRequestFactory) {
        self.router = router
        self.requestFactory = requestFactory
    }
}

// MARK: - AuthPresenter + AuthViewOutput

extension LoaderScreenPresenter: LoaderScreenViewOutput {
 
    // MARK: - Public methods
    
    func setup() {
        sendRequest { [weak self] status in
            guard !status, let self = self else { return }
            
            DispatchQueue.main.async {
                self.view.reconnectButton.addTarget(self,
                                                    action: #selector(self.didTapRetryAgain),
                                                    for: .touchUpInside)
                self.view.setupReconnectButton()
            }
        }
    }
}

// MARK: - LoaderScreenPresenter + private extension

private extension LoaderScreenPresenter {
    var view: LoaderScreenView {
        return input?.loaderScreenView ?? LoaderScreenView()
    }
    
    func sendRequest(completion: BoolClouser? = nil) {
        view.messageLabel.text = ""
        view.activityIndicatorView.startAnimating()
        view.setupAndStartActivityIndicator()
            
        requestFactory.checkValidToken(accessToken: AppData.accessToken) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.view.activityIndicatorView.stopAnimating()
            }
            
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    DispatchQueue.main.async {
                        self.router.onShowMainScreen?()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.router.showAuth()
                    }
                }
                completion?(true)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.messageLabel.text = "Server is invalid\n\nMessage: \(error.localizedDescription)"
                }
                
                completion?(false)
                logging(error.localizedDescription)
            }
        }
    }
    
    @objc func didTapRetryAgain() {
        sendRequest()
    }
}
