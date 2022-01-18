//
//  SignUpPresenter.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

protocol SignUpViewInput: AnyObject {
    var signUpView: SignUpView { get }
    func showError(error: String)
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
    
    weak var input: (UIViewController & SignUpViewInput)?
    
    let router: StartRouter
    let requestFactory: UserRequestFactory
    
    required init(router: StartRouter, requestFactory: UserRequestFactory) {
        self.router = router
        self.requestFactory = requestFactory
    }
}

// MARK: - SignUpPresenter + SignUpViewOutput

extension SignUpPresenter: SignUpViewOutput {
    
    // MARK: - Public methods
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
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
                         wrongMessage: "a-z, A-Z, 0-9 и мин. длинна: 6 сим.",
                         string: string,
                         range: range)
        default:
            break
        }
        
        return false
    }
    
    func configureController() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        view.signInButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
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

// MARK: SignUpPresenter + private extension

private extension SignUpPresenter {
    
    // MARK: - Private properties
    
    var view: SignUpView {
        return input?.signUpView ?? SignUpView()
    }
    
    // MARK: - Private methods
    
    @objc func keyboardWasShown(notification: Notification) {
        
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardFrameValue = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let kbSize = keyboardFrameValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        view.scrollView.contentInset = contentInsets
        view.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        view.scrollView.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        view.scrollView.endEditing(true)
    }
    
    @objc func didTapSignUp() {
        guard checkValidFields(), let profile = generateProfile() else {
            input?.showError(error: "Проверьте обязательные поля")
            return
        }
        
        showActivityIndicator(isShow: true)
        
        requestRegistration(for: profile) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
    
    func generateProfile() -> ProfileResult? {
        guard let login = view.loginTextField.text,
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
    
    func checkValidFields() -> Bool {
        let validLabels = [view.loginValidLabel,
                           view.nameValidLabel,
                           view.phoneValidLabel,
                           view.cardValidLabel,
                           view.passwordValidLabel]
        
        let isContains = validLabels.contains(where: { $0.tag == Tag.invalid.rawValue })
        
        return isContains ? false : true
    }
    
    func requestRegistration(for profile: ProfileResult, completion: VoidClouser?) {
        requestFactory.register(for: profile, completionHandler: { [weak self] response in
            switch response.result {
            case let .success(registration):
                if registration.result == 1,
                   let accessToken = registration.user?.accessToken,
                   let name = registration.user?.fullName {
                    AppData.accessToken = accessToken
                    AppData.fullName = name
                    
                    DispatchQueue.main.async {
                        self?.router.onShowMainScreen?()
                    }
                    
                } else if let errorMessage = registration.errorMessage {
                    logging(errorMessage)
                    DispatchQueue.main.async {
                        self?.input?.showError(error: errorMessage)
                    }
                }
            case let .failure(error):
                logging(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.input?.showError(error: error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                completion?()
            }
        })
    }
    
    func setTextField(textField: UITextField,
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
            setValidLabel(label, isValid: true, text: view.validSymbol)
        } else {
            setValidLabel(label, isValid: false, text: wrongMessage)
        }
    }
    
    func setPhoneNumberMask(textField: UITextField,
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
            setValidLabel(label, isValid: true, text: view.validSymbol)
        } else {
            setValidLabel(label, isValid: false, text: "Неверный формат...")
        }
        
        return result
    }
    
    func setCardMask(textField: UITextField,
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
            setValidLabel(label, isValid: true, text: view.validSymbol)
        } else if result.isEmpty {
            label.text = "Необязательно"
            label.textColor = .label
            label.tag = Tag.valid.rawValue
        } else {
            setValidLabel(label, isValid: false, text: "Неверный формат...")
        }
        
        return result
    }
    
    func setValidLabel(_ label: UILabel, isValid: Bool, text: String?) {
        if isValid {
            label.textColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0, alpha: 1)
            label.tag = Tag.valid.rawValue
        } else {
            label.textColor = #colorLiteral(red: 0.5783785502, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            label.tag = Tag.invalid.rawValue
        }
        
        label.text = text
    }
    
    func showActivityIndicator(isShow: Bool) {
        isShow ? view.activityIndicatorView.startAnimating() : view.activityIndicatorView.stopAnimating()
    }
}
