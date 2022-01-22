//
//  LoaderScreenView.swift
//  Shop
//
//  Created by Ilya on 23.01.2022.
//

import UIKit

class LoaderScreenView: UIView {

    // MARK: - Private set properties
    
    private(set) var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: bounds)
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var reconnectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry again", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Inits

    init() {
        super.init(frame: .zero)

        addSubview(messageLabel)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setupAndStartActivityIndicator() {
        addSubview(messageLabel)
        addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            messageLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            messageLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5),
            
            activityIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            activityIndicatorView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupReconnectButton() {
        addSubview(reconnectButton)
        
        NSLayoutConstraint.activate([
            reconnectButton.centerXAnchor.constraint(equalTo: messageLabel.centerXAnchor),
            reconnectButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10)
        ])
    }
}
