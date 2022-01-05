//
//  AuthViewController.swift
//  Shop
//
//  Created by Ilya on 02.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Public properties
    
    var requestFactory: RequestFactory
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: view.bounds)
        view.style = .large
        return view
    }()

    // MARK: - Private properties
    
    private var presenter: MainViewOutput
    
    // MARK: - Inits
    
    init(presenter: MainViewOutput, requestFactory: RequestFactory) {
        self.presenter = presenter
        self.requestFactory = requestFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
    }
}

// MARK: - AuthViewController + MainViewInput

extension AuthViewController: MainViewInput {
    
    func showError(error: Error) {
        showAlert(with: error.localizedDescription)
    }
    
    func showLoginResult(result: LoginResult) {
        showAlert(with: "Hello, \(result.user.firstName)!" )
    }
    
    func showLogoutResult(result: LogoutResult) {
        showAlert(with: "Logout result is \(result.result)" )
    }
}

// MARK: - SwiftUI

import SwiftUI

struct MainProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController(presenter: AuthPresenter(),
                                                requestFactory: RequestFactory())
        
        func makeUIViewController(
            context: UIViewControllerRepresentableContext<MainProvider.ContainerView>
        ) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: MainProvider.ContainerView.UIViewControllerType,
                                    context: UIViewControllerRepresentableContext<MainProvider.ContainerView>) {
        }
    }
}
