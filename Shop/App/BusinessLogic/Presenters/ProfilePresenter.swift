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
    init(router: ProfileRouter, signOut: VoidClouser?)
    func didTapSignOut()
}

class ProfilePresenter: ProfilePresenterOutput {
    
    private let router: ProfileRouter
    private let signOut: VoidClouser?
    
    required init(router: ProfileRouter, signOut: VoidClouser?) {
        self.router = router
        self.signOut = signOut
    }
    
    func didTapSignOut() {
        signOut?()
    }
}
