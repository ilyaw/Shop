//
//  AuthViewController.swift
//  Shop
//
//  Created by Ilya on 02.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    var presenter: MainViewOutput
    var requestFactory: RequestFactory
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: view.bounds)
        view.style = .large
        return view
    }()
    
    init(presenter: MainViewOutput, requestFactory: RequestFactory) {
        self.presenter = presenter
        self.requestFactory = requestFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: MainViewInput

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
