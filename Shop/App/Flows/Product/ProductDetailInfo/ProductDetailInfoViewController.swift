//
//  ProductDetailInfoViewController.swift
//  Shop
//
//  Created by Ilya on 12.01.2022.
//

import UIKit

class ProductDetailInfoViewController: UIViewController, ViewSpecificController {
    typealias RootView = ProductDetailInfoView
    
    // MARK: - Private properties
    
    private let presenter: ProductPresenterOutput
    
    init(presenter: ProductPresenterOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = ProductDetailInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData()
    }
}

// MARK: - ProductViewController + ProductPresenterInput

extension ProductDetailInfoViewController: ProductPresenterInput {
    var productView: ProductDetailInfoView {
        return view() ?? ProductDetailInfoView()
    }
}
