//
//  RegisterPresenter.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

protocol SignUpViewInput: AnyObject {
    var signUpView: SignUpView { get }
    func showError(error: String)
    func showMainTabbar()
}

protocol SignUpViewOutput: AnyObject {
    init(router: StartRouter, requestFactory: UserRequestFactory)
    func configureController()
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
}

class SignUpPresenter {
    
    // MARK: - Public properties
    
    weak var viewInput: (UIViewController & SignUpViewInput)?
    
    let router: StartRouter
    let requestFactory: UserRequestFactory
    
    required init(router: StartRouter, requestFactory: UserRequestFactory) {
        self.router = router
        self.requestFactory = requestFactory
    }
    
    // MARK: - Private methods
    
    @objc private func keyboardWasShown(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardFrameValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let kbSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        viewInput?.signUpView.scrollView.contentInset = contentInsets
        viewInput?.signUpView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        viewInput?.signUpView.scrollView.contentInset = contentInsets
    }
    
    @objc private func hideKeyboard() {
        viewInput?.signUpView.scrollView.endEditing(true)
    }
    
    @objc private func didTapSignUp() {
        guard let profile = generateProfile() else {
            viewInput?.showError(error: "Проверьте обязательные поля")
            return
        }
        
        requestRegistration(for: profile)
    }
    
    private func generateProfile() -> ProfileResult? {
        guard let view = viewInput?.signUpView,
              let login = view.loginTextField.text,
              !login.isEmpty,
              let name = view.nameTextField.text,
              !name.isEmpty,
              let phone = view.phoneNumberTextField.text,
              !phone.isEmpty,
              let card = view.cardTextField.text,
              let password = view.passwordTextField.text,
              !password.isEmpty else { return nil }
        
        let profile = ProfileResult(login: login,
                                    password: password,
                                    fullName: name,
                                    phone: phone,
                                    creditCard: card.isEmpty ? nil : card)
        
        return profile
    }
    
    private func requestRegistration(for profile: ProfileResult) {
        requestFactory.register(for: profile, completionHandler: { [weak self] response in
            switch response.result {
            case let .success(registration):
                if registration.result == 1 {
                    print(registration)
                } else if let errorMessage = registration.errorMessage {
                    DispatchQueue.main.async {
                        self?.viewInput?.showError(error: errorMessage)
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self?.viewInput?.showError(error: error.localizedDescription)
                }
            }
        })
    }
    
    private func setTextField(textField: UITextField,
                              label: UILabel,
                              validType: String.ValidTypes,
                              wrongMessage: String,
                              string: String,
                              range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = viewInput?.signUpView.validSymbol
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
    }
    
    private func setPhoneNumberMask(textField: UITextField,
                                    label: UILabel,
                                    mask: String,
                                    string: String,
                                    range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            label.text = viewInput?.signUpView.validSymbol
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else {
            label.text = "Неверный формат..."
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        
        return result
    }
    
    private func setCardMask(textField: UITextField,
                             label: UILabel,
                             mask: String,
                             string: String,
                             range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 19 {
            label.text = viewInput?.signUpView.validSymbol
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
        } else if result.isEmpty {
            label.text = "Необязательно"
            label.textColor = .label
        } else {
            label.text = "Неверный формат..."
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        
        return result
    }
}

// MARK: - SignUpPresenter + SignUpViewOutput

extension SignUpPresenter: SignUpViewOutput {
    
    // MARK: - Public methods
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let view = viewInput?.signUpView else { return false }
        
        switch textField {
        case view.loginTextField:
            setTextField(textField: view.loginTextField,
                         label: view.loginValidLabel,
                         validType: .login,
                         wrongMessage: "a-z, A-Z, мин. 2 символ",
                         string: string,
                         range: range)
            
        case view.nameTextField:
            setTextField(textField: view.nameTextField,
                         label: view.nameValidLabel,
                         validType: .name,
                         wrongMessage: "мин. 2 буквы",
                         string: string,
                         range: range)
            
        case view.phoneNumberTextField:
            view.phoneNumberTextField.text = setPhoneNumberMask(textField: view.phoneNumberTextField,
                                                                label: view.phoneValidLabel,
                                                                mask: "+X (XXX) XXX-XX-XX",
                                                                string: string,
                                                                range: range)
        case view.cardTextField:
            view.cardTextField.text = setCardMask(textField: view.cardTextField,
                                                  label: view.cardValidLabel,
                                                  mask: "XXXX-XXXX-XXXX-XXXX",
                                                  string: string,
                                                  range: range)
            
        case view.passwordTextField:
            setTextField(textField: view.passwordTextField,
                         label: view.passwordValidLabel,
                         validType: .password,
                         wrongMessage: "По 1 сим.: a-z, A-Z, 0-9 и мин. длинна: 6 сим.",
                         string: string,
                         range: range)
        default:
            break
        }
        
        return false
    }
    
    func configureController() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        viewInput?.signUpView.scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        viewInput?.signUpView.signInButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    func addObserverForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserverForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
