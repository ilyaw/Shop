//
//  ProfileView.swift
//  Shop
//
//  Created by Ilya on 14.01.2022.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Private set properties
    
    private(set) lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "card")
        return imageView
    }()
    
    private(set) lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 20, weight: .ultraLight)
        return label
    }()
    
    private(set) lazy var cardInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Карта отсутсвует."
        return label
    }()
    
    private(set) lazy var openSettingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить карту", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI(existCard: ExistCard) {
        self.backgroundColor = .systemBackground
        
        switch existCard {
        case .yes:
            setupCard()
        case .no:
            setupNoCardInforamation()
        }
    }
}

// MARK: - ProfileView + private extension

private extension ProfileView {
    
    func setupCard() {
        addSubview(cardImageView)
        addSubview(balanceLabel)
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,
                                                constant: Constant.indentLeft),
            cardImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,
                                                 constant: Constant.indentRight),
            cardImageView.heightAnchor.constraint(equalToConstant: Constant.cardHeight),
            
            balanceLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor,
                                              constant: Constant.indentTop),
            balanceLabel.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor)
        ])
    }
    
    func setupNoCardInforamation() {
        addSubview(cardInformationLabel)
        addSubview(openSettingsButton)
        
        NSLayoutConstraint.activate([
            cardInformationLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            cardInformationLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            openSettingsButton.topAnchor.constraint(equalTo: cardInformationLabel.bottomAnchor,
                                                    constant: Constant.indentTop),
            openSettingsButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,
                                                     constant: Constant.indentLeft),
            openSettingsButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,
                                                      constant: Constant.indentRight)
        ])
    }
}

// MARK: - ProfileView + extension

extension ProfileView {
    enum ExistCard {
        case yes, no
    }
}

// MARK: - ProfileView + private extension

private extension ProfileView {
    struct Constant {
        static let cardHeight: CGFloat = 250.0
        
        static let indentLeft: CGFloat = 10.0
        static let indentRight: CGFloat = -10.0
        static let indentTop: CGFloat = 10.0
        static let indentBottom: CGFloat = -10.0
        
    }
}
