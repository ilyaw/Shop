//
//  SettingsViewController.swift
//  Shop
//
//  Created by Ilya on 16.01.2022.
//

import UIKit
import SPAlert

class SettingsViewController: UIViewController, ViewSpecificController {
    typealias RootView = SettingsView
    
    // MARK: - Private properties
    
    private let presenter: SettingsPresenterOutput
    
    // MARK: - Inits
    
    init(presenter: SettingsPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        
        presenter.getUserData()
        presenter.configureController()
    }
        
    override func loadView() {
        view = SettingsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.addObserverForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.removeObserverForKeyboardNotification()
    }
}

// MARK: - SettingsViewController + private extension

private extension SettingsViewController {
    func setupUI() {
        navigationItem.title = "Настройки"
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "xmark.circle"),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(didTapCloseSettings))
    }
    
    private func setupDelegates() {
        profileView.nameTextField.delegate = self
        profileView.phoneNumberTextField.delegate = self
        profileView.cardTextField.delegate = self
    }
    
    @objc func didTapCloseSettings() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - SettingsViewController + SettingsPresenterInput

extension SettingsViewController: SettingsPresenterInput {
    
    // MARK: - Public properties
    
    var profileView: SettingsView {
        return view() ?? SettingsView()
    }
    
    // MARK: - Public methods
    
    func showError(error: String) {
        SPAlert.present(message: error, haptic: .error)
    }
    
    func showResult(message: String) {
        let alertView = SPAlertView(title: "Успешно обновлено", preset: .done)
        alertView.duration = 2
        alertView.present(haptic: .success) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - SettingsViewController + UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let result = presenter.textField(textField,
                                         shouldChangeCharactersIn: range,
                                         replacementString: string)
        
        return result
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileView.nameTextField.resignFirstResponder()
        profileView.phoneNumberTextField.resignFirstResponder()
        profileView.cardTextField.resignFirstResponder()
        return true
    }
}
