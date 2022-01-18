//
//  ProfilePresenter.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import Foundation
import UIKit

protocol ProfilePresenterInput {
    var profileView: ProfileView { get }
}

protocol ProfilePresenterOutput {
    init(router: ProfileRouter, requestFactory: UserRequestFactory, signOut: VoidClouser?)
    func didTapSignOut()
    func getInfoCart()
    func openSettings()
}

class ProfilePresenter: ProfilePresenterOutput {
    
    // MARK: - Public properties
    
    weak var input: (UIViewController & ProfilePresenterInput)?
    
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
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.setupProfileView(cardInfoResponse: result.card)
                }
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    func didTapSignOut() {
        signOut?()
    }
    
    @objc func openSettings() {
        router.openSettings()
    }
}

// MARK: - ProfilePresenter + private extension

private extension ProfilePresenter {
        
    func setImageNumberAndName(numberCard: String, name: String) {
        let staticPositionYForCardNumber: CGFloat = 346.0
        let staticPositionYForCardName: CGFloat = 541.0
        let staticPositionXForCardName: CGFloat = 80.0
        
        guard let cardImageView = input?.profileView.cardImageView,
              var cardImage = cardImageView.image,
              let helveticaBold70 = UIFont(name: "Helvetica Bold", size: 70),
              let helvetica55 = UIFont(name: "Helvetica", size: 55),
              let cardWithNumberImage = textToImage(text: numberCard as NSString,
                                                    toImage: cardImage,
                                                    atPoint: CGPoint(x: cardImageView.frame.midX - 50,
                                                                     y: staticPositionYForCardNumber),
                                                    textFont: helveticaBold70) else { return }
        
        cardImage = cardWithNumberImage
        
        guard let cardWithNameImage = textToImage(text: name as NSString,
                                                  toImage: cardImage,
                                                  atPoint: CGPoint(x: staticPositionXForCardName,
                                                                   y: staticPositionYForCardName),
                                                  textFont: helvetica55) else { return }
        
        cardImage = cardWithNameImage
        
        self.input?.profileView.cardImageView.image = cardImage
    }
    
    func textToImage(text: NSString,
                     toImage image: UIImage,
                     atPoint point: CGPoint,
                     textFont: UIFont) -> UIImage? {
        let textColor = UIColor.white
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func setupProfileView(cardInfoResponse: CardInfoResult.Card?) {
        guard let view = self.input?.profileView, let card = cardInfoResponse else {
            self.input?.profileView.setupUI(existCard: .no)
            self.input?.profileView.openSettingsButton.addTarget(self,
                                                                     action: #selector(openSettings),
                                                                     for: .touchUpInside)
            return
        }
        
        view.setupUI(existCard: .yes)
        view.balanceLabel.text = "Баланс: \(card.money) ₽"
        view.layoutIfNeeded()
        
        self.setImageNumberAndName(numberCard: card.creditCard, name: AppData.fullName)
    }
}
