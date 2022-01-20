//
//  HomeViewController.swift
//  Shop
//
//  Created by Ilya on 06.01.2022.
//

import UIKit

class HomeViewController: UIViewController, ViewSpecificController {
    typealias RootView = HomeView
    
    // MARK: - Private properties
    
    private var presenter: HomePresenter
    
    // MARK: - Inits
    
    init(presenter: HomePresenter) {
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
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    deinit {
        print("deinit HomeViewController")
    }
}

// MARK: - HomeViewController + HomePresenterInput

extension HomeViewController: HomePresenterInput {
    var homeView: HomeView {
        return view() ?? HomeView()
    }
}

// MARK: - HomeViewController + private extension

private extension HomeViewController {
    func setupUI() {
        navigationItem.title = "Shop"

        presenter.setupCollectionView()
    }
}
