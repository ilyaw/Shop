//
//  ProfilePresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import Foundation

protocol ProfilePresenterInput {
    
}

protocol ProfilePresenterOutput {
    init(router: ProfileRouter, requestFactory: UserRequestFactory, signOut: VoidClouser?)
    func didTapSignOut()
    func getInfoCart()
}

class ProfilePresenter: ProfilePresenterOutput {
    
    // MARK: - Private properties
    
    private let router: ProfileRouter
    private let requestFactory: UserRequestFactory
    private let signOut: VoidClouser?
    
    // MARK: - Inits
    
    required init(router: ProfileRouter, requestFactory: UserRequestFactory, signOut: VoidClouser?) {
        self.router = router
        self.requestFactory = requestFactory
        self.signOut = signOut
    }
    
    // MARK: - Public methods
    
    func getInfoCart() {
        let accessToken = AppData.accessToken
        
        requestFactory.getCardInfo(accessToken: accessToken) { [weak self] response in
            guard let self = self else { return }
            _ = self.router

            switch response.result {
            case .success(let cardInfo):
                print(cardInfo)
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    func didTapSignOut() {
        signOut?()
    }
}
