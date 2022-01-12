//
//  SignUpView.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

class SignUpView: UIView {
    
    // MARK: - Public properties
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: bounds)
        view.style = .large
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let loginLabel = UILabel(text: "Логин")
    let nameLabel = UILabel(text: "Имя")
    let phoneLabel = UILabel(text: "Телефон")
    let cardLabel = UILabel(text: "Карта")
    let passwordLabel = UILabel(text: "Пароль")
    
    let loginTextField = OneLineTextField(font: .avenir20())
    let nameTextField = OneLineTextField(font: .avenir20())
    let phoneNumberTextField = OneLineTextField(font: .avenir20())
    let cardTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    let signInButton = UIButton(title: "Зарегистироваться",
                                titleColor: .white,
                                backgroundColor: .buttonPurple(),
                                cornerRadius: 4)
    
    let validSymbol = "\u{2713}"
    
    let loginValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Необязательно"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI {
            setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI {
            setupConstraints()
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI(competion: () -> Void) {
        self.backgroundColor = .systemBackground
        self.addSubview(activityIndicatorView)
        
        passwordTextField.isSecureTextEntry = true
        phoneNumberTextField.keyboardType = .numberPad
        
        competion()
    }
    
    private func createStubView() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.backgroundColor = .systemBackground
        return view
    }
    
    private func setupConstraints() {
        let loginStackView = UIStackView(arrangedSubviews: [loginLabel,
                                                            loginTextField,
                                                            createStubView(),
                                                            loginValidLabel],
                                         axis: .vertical,
                                         spacing: 0)
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,
                                                           nameTextField,
                                                           createStubView(),
                                                           nameValidLabel],
                                        axis: .vertical,
                                        spacing: 0)
        
        let phoneStackView = UIStackView(arrangedSubviews: [phoneLabel,
                                                            phoneNumberTextField,
                                                            createStubView(),
                                                            phoneValidLabel],
                                         axis: .vertical,
                                         spacing: 0)
        
        let cardStackView = UIStackView(arrangedSubviews: [cardLabel,
                                                           cardTextField,
                                                           createStubView(),
                                                           cardValidLabel],
                                        axis: .vertical,
                                        spacing: 0)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,
                                                               passwordTextField,
                                                               createStubView(),
                                                               passwordValidLabel],
                                            axis: .vertical,
                                            spacing: 0)
        
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [loginStackView,
                                                       nameStackView,
                                                       phoneStackView,
                                                       cardStackView,
                                                       passwordStackView,
                                                       signInButton],
                                    axis: .vertical,
                                    spacing: 20)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        let viewSafeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: viewSafeArea.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            stackView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}
