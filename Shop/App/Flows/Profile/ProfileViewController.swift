//
//  ProfileViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class ProfileViewController: UIViewController, ViewSpecificController {
    typealias RootView = ProfileView
    
    // MARK: - Private properties
    
    private let presenter: ProfilePresenterOutput
    
    // MARK: - Inits
    
    init(presenter: ProfilePresenterOutput) {
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
        presenter.getInfoCart()
    }
    
    override func loadView() {
        view = ProfileView()
    }
}

// MARK: - ProfileViewController + private extension  {

private extension ProfileViewController {
    func setupUI() {
        view()?.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = AppData.fullName
        
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "gear"),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(didTapOpenSettings))
    }
    
    @objc func didTapOpenSettings() {
        presenter.openSettings()
    }
}

// MARK: - ProfileViewController + ProfilePresenterInput

extension ProfileViewController: ProfilePresenterInput {
    
    var profileView: ProfileView {
        view() ?? ProfileView()
    }
}
