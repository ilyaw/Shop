//
//  CatalogViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class CatalogViewController: UIViewController, ViewSpecificController {
    typealias RootView = CatalogView
    
    // MARK: - Private properties
    
    var presenter: CatalogPresenter
    
    // MARK: - Inits
    
    init(presenter: CatalogPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = CatalogView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - CatalogViewController + CatalogPresenterInput

extension CatalogViewController: CatalogPresenterInput {
    var catalogView: CatalogView {
        return view() ?? CatalogView()
    }
}

// MARK: - CatalogViewController + private extension

private extension CatalogViewController {
    func setupUI() {
        presenter.setupCollectionView()
    }
}
