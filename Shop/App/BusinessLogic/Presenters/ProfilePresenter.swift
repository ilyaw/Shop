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
    init(router: ProfileRouter)
    func didTapSignOut()
}

class ProfilePresenter: ProfilePresenterOutput {
    private let router: ProfileRouter
    var signOut: VoidClouser?
    
    required init(router: ProfileRouter) {
        self.router = router
    }
    
    func didTapSignOut() {
        signOut?()
    }
}
