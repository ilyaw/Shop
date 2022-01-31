//
//  LoaderScreenViewController.swift
//  Shop
//
//  Created by Ilya on 23.01.2022.
//

import UIKit

class LoaderScreenViewController: UIViewController, ViewSpecificController {
    typealias RootView = LoaderScreenView
    
    // MARK: - Private properties
    
    private let presenter: LoaderScreenViewOutput
    
    // MARK: - Inits
    
    init(presenter: LoaderScreenViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = LoaderScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
    }
}

// MARK: - LoaderScreenViewController + LoaderScreenViewInput

extension LoaderScreenViewController: LoaderScreenViewInput {
    var loaderScreenView: LoaderScreenView {
        return view() ?? LoaderScreenView()
    }
}
