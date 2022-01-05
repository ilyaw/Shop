//
//  NoConnectionViewController.swift
//  Shop
//
//  Created by Ilya on 03.01.2022.
//

import UIKit

class NoConnectionViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPurple
        label.text = "No connection 🥲"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let reconnectButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Retry again", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc
    private func didTapRetryAgain() {
        let baseURL = BaseURL()
        
        baseURL.url.сheckWebsiteAvailability { [weak self] isValid in
            if isValid {
                DispatchQueue.main.async {
                    let tabbar = MainTabBar()
                    UIApplication.setRootVC(viewController: tabbar)
                }
            } else {
                DispatchQueue.main.async {
                    self?.startAnimationChangeTextErrorLabel()
                }
            }
        }
    }
    
    private func startAnimationChangeTextErrorLabel() {
        UIView.transition(with: errorMessageLabel,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            if self.errorMessageLabel.text == "No connection 🥲" {
                self.errorMessageLabel.text = "No connection 🥶"
            } else {
                self.errorMessageLabel.text = "No connection 🥲"
            }
        }, completion: nil)
    }
    
    private func setupUI() {
        reconnectButton.addTarget(self, action: #selector(didTapRetryAgain), for: .touchUpInside)
        
        view.backgroundColor = .systemBackground
        view.addSubview(errorMessageLabel)
        view.addSubview(reconnectButton)
        
        setTamic()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            reconnectButton.centerXAnchor.constraint(equalTo: errorMessageLabel.centerXAnchor),
            reconnectButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setTamic() {
        _ = [errorMessageLabel, reconnectButton].map { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}

// MARK: - SwiftUI

import SwiftUI

struct NoConnectionProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = NoConnectionViewController()
        
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<NoConnectionProvider.ContainerView>
        ) -> NoConnectionViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: NoConnectionProvider.ContainerView.UIViewControllerType,
                                    context: UIViewControllerRepresentableContext<NoConnectionProvider.ContainerView>) {
        }
    }
}
