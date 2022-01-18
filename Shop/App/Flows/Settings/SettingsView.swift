//
//  SettingsView.swift
//  Shop
//
//  Created by Ilya on 16.01.2022.
//

import UIKit

class SettingsView: UIView {
    
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
    
    let nameLabel = UILabel(text: "Имя")
    let phoneLabel = UILabel(text: "Телефон")
    let cardLabel = UILabel(text: "Карта")
    
    let nameTextField = OneLineTextField(font: .avenir20())
    let phoneNumberTextField = OneLineTextField(font: .avenir20())
    let cardTextField = OneLineTextField(font: .avenir20())
    
    let validSymbol = "\u{2713}"
    
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
        label.text = "Обязательное поле"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notificationSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    let saveInforamtionButton = UIButton(title: "Сохранить",
                                         titleColor: .white,
                                         backgroundColor: .buttonPurple(),
                                         isShadow: true,
                                         cornerRadius: 4)
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти из аккаунт", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        addSubviewsAndSetConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
        
        phoneNumberTextField.keyboardType = .numberPad
        cardTextField.keyboardType = .numberPad
    }
    
    func fillTextFeilds(userInfo: UserInfo) {
        nameTextField.text = userInfo.name
        phoneNumberTextField.text = userInfo.phone
        cardTextField.text = userInfo.card
    }
}

// MARK: - SettingsView + private extension

private extension SettingsView {
    enum Constant {
        static let indentTop: CGFloat = 10
        static let indentLeft: CGFloat = 20
        static let indentRight: CGFloat = -20
        static let indentBottom: CGFloat = -20
    }
    
    func addSubviewsAndSetConstraints() {
        let stackView = createUIElementWithStack()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        
        let viewSafeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: viewSafeArea.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constant.indentTop),
            stackView.leftAnchor.constraint(equalTo: viewSafeArea.leftAnchor, constant: Constant.indentLeft),
            stackView.rightAnchor.constraint(equalTo: viewSafeArea.rightAnchor, constant: Constant.indentRight),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: Constant.indentBottom)
        ])
    }
    
    func createUIElementWithStack() -> UIStackView {
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,
                                                           nameTextField,
                                                           createEmpyView(),
                                                           nameValidLabel],
                                        axis: .vertical,
                                        spacing: 0)
        
        let phoneStackView = UIStackView(arrangedSubviews: [phoneLabel,
                                                            phoneNumberTextField,
                                                            createEmpyView(),
                                                            phoneValidLabel],
                                         axis: .vertical,
                                         spacing: 0)
        
        let cardStackView = UIStackView(arrangedSubviews: [cardLabel,
                                                           cardTextField,
                                                           createEmpyView(),
                                                           cardValidLabel],
                                        axis: .vertical,
                                        spacing: 0)
        
        let notificationTitleLabel = UILabel(text: "Уведомления",
                                             font: .boldSystemFont(ofSize: 20))
        
        let notificationTextLabel = UILabel(text: "Сообщать о бонусах, акциях и новых продуктах",
                                            font: .systemFont(ofSize: 16))
        notificationTextLabel.numberOfLines = 0
        
        let notificationSubtextLabel = UILabel(text: "Пуш-уведомления, эл. почта, смс",
                                               font: .systemFont(ofSize: 13))
        notificationSubtextLabel.numberOfLines = 0
        notificationSubtextLabel.textColor = .gray
        
        let notificationLabelesStack = UIStackView(arrangedSubviews: [notificationTextLabel,
                                                                      notificationSubtextLabel],
                                                   axis: .vertical,
                                                   spacing: 0)
        
        let notificationStack = UIStackView(arrangedSubviews: [notificationLabelesStack,
                                                               notificationSwitch],
                                            axis: .horizontal,
                                            spacing: 0)
        notificationStack.alignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView,
                                                       phoneStackView,
                                                       cardStackView,
                                                       notificationTitleLabel,
                                                       notificationStack,
                                                       saveInforamtionButton,
                                                       signOutButton],
                                    axis: .vertical,
                                    spacing: 20)
        
        return stackView
    }
    
    func createEmpyView() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.backgroundColor = .systemBackground
        return view
    }
}
