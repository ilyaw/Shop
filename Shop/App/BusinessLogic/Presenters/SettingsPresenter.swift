//
//  SettingsPresenter.swift
//  Shop
//
//  Created by Ilya on 16.01.2022.
//

import UIKit

protocol SettingsPresenterInput: AnyObject {
    var profileView: SettingsView { get }
    func showError(error: String)
    func showResult(message: String)
}

protocol SettingsPresenterOutput: AnyObject {
    init(requestFactory: UserRequestFactory, signOut: VoidClouser?)
    func getUserData()
    func addObserverForKeyboardNotification()
    func removeObserverForKeyboardNotification()
    func configureController()
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
}

class SettingsPresenter: SettingsPresenterOutput {
    
    // MARK: - Public properties
    
    weak var input: SettingsPresenterInput?
    
    // MARK: - Private properties
    
    private let requestFactory: UserRequestFactory
    private let signOut: VoidClouser?
    
    required init(requestFactory: UserRequestFactory, signOut: VoidClouser?) {
        self.requestFactory = requestFactory
        self.signOut = signOut
    }
    
    func getUserData() {
        requestFactory.getUserInfo(accessToken: AppData.accessToken) { [weak self] response in
            switch response.result {
            case .success(let result):
                guard let user = result.user else { return }
                
                DispatchQueue.main.async {
                    self?.view.fillTextFeilds(userInfo: user)
                    self?.checkValidUserData(userInfo: user)
                }
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    func configureController() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.scrollView.addGestureRecognizer(hideKeyboardGesture)
        
        view.saveInforamtionButton.addTarget(self,
                                             action: #selector(didTapSaveInformation),
                                             for: .touchUpInside)
        
        view.signOutButton.addTarget(self,
                                     action: #selector(didTapSignOut),
                                     for: .touchUpInside)
        
        view.notificationSwitch.isOn = AppData.isAcitvePushNotification
    }
    
    func addObserverForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserverForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        switch textField {
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
        default:
            break
        }
        
        return false
    }
}

// MARK: - SettingsPresenter + private extension

private extension SettingsPresenter {
    
    // MARK: - Private properties
    
    var view: SettingsView {
        return input?.profileView ?? SettingsView()
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
    
    @objc private func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        view.scrollView.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        view.scrollView.endEditing(true)
    }
    
    @objc func didTapSaveInformation() {
        guard checkValidFields(), let profile = generateProfile() else {
            input?.showError(error: "Проверьте обязательные поля")
            return
        }
        
        showActivityIndicator(isShow: true)
        
        requestUpdateUserInfo(for: profile) { [weak self] in
            self?.showActivityIndicator(isShow: false)
        }
    }
    
    @objc func didTapSignOut() {
        signOut?()
    }
    
    func requestUpdateUserInfo(for profile: UpdateUser, completion: VoidClouser?) {
        requestFactory.change(for: profile) { [weak self] response in
            switch response.result {
            case .success(let update):
                if update.result == 1, let message = update.userMessage {
                    AppData.fullName = profile.name
                    
                    DispatchQueue.main.async {
                        AppData.isAcitvePushNotification = self?.view.notificationSwitch.isOn ?? false
                        self?.input?.showResult(message: message)
                    }
                } else if let errorMessage = update.errorMessage {
                    logging(errorMessage)
                    
                    DispatchQueue.main.async {
                        self?.input?.showError(error: errorMessage)
                    }
                }
                
            case .failure(let error):
                logging(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self?.input?.showError(error: error.localizedDescription)
                }
            }
        }
    }
    
    func showActivityIndicator(isShow: Bool) {
        isShow ? view.activityIndicatorView.startAnimating() : view.activityIndicatorView.stopAnimating()
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
            label.text = "Обязательное поле"
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
    
    func checkValidUserData(userInfo: UserInfo) {
        let isNameValid = userInfo.name.isValid(validType: .name)
        let isPhoneValid = userInfo.phone.isValid(validType: .phone)
        let isCardValid = userInfo.card?.isValid(validType: .card) ?? false
        
        setValidLabel(view.nameValidLabel,
                      isValid: isNameValid,
                      text: isNameValid ? view.validSymbol : "мин. 2 буквы")
        
        setValidLabel(view.phoneValidLabel,
                      isValid: isPhoneValid,
                      text: isPhoneValid ? view.validSymbol : "Неверный формат...")
        
        setValidLabel(view.cardValidLabel,
                      isValid: isCardValid,
                      text: isCardValid ? view.validSymbol : "Неверный формат...")
    }
    
    func generateProfile() -> UpdateUser? {
        guard let name = view.nameTextField.text,
              !name.isEmpty,
              let phone = view.phoneNumberTextField.text,
              !phone.isEmpty,
              let card = view.cardTextField.text,
              !card.isEmpty else { return nil }
        
        let updateUser = UpdateUser(accessToken: AppData.accessToken,
                                    name: name,
                                    phone: phone,
                                    card: card)
        return updateUser
    }
    
    func checkValidFields() -> Bool {
        let validLabels = [view.nameValidLabel,
                           view.phoneValidLabel,
                           view.cardValidLabel]
        
        let isContains = validLabels.contains(where: { $0.tag == Tag.invalid.rawValue })
        
        return isContains ? false : true
    }
}
