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
    
    let welcomeLabel = UILabel(text: "Good to see you!🙋‍♂️", font: .avenir26())
    
    let loginLabel = UILabel(text: "Login")
    let passwordLabel = UILabel(text: "Password")
    
    let loginTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    let signInButton = UIButton(title: "Sign In", titleColor: .white, backgroundColor: .buttonPurple(), cornerRadius: 4)
    
    let needAnAccountLabel = UILabel(text: "Need an account?")
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
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
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupConstraints() {
        
        let loginStackView = UIStackView(arrangedSubviews: [loginLabel, loginTextField],
                                         axis: .vertical,
                                         spacing: 0)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField],
                                            axis: .vertical,
                                            spacing: 0)
        
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [loginStackView, passwordStackView, signInButton],
                                    axis: .vertical,
                                    spacing: 40)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton],
                                          axis: .horizontal,
                                          spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 160),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            bottomStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            bottomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
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
