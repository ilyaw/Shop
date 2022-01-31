//
//  ProductViewController.swift
//  Shop
//
//  Created by Ilya on 24.01.2022.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let productDetailInfoController: ProductDetailInfoViewController
    
    private var productView: ProductView {
        return (view as? ProductView) ?? ProductView()
    }
    
    // MARK: - Inits
    
    init(productDetailInfoController: ProductDetailInfoViewController) {
        self.productDetailInfoController = productDetailInfoController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = ProductView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - ProductViewController + private extension

private extension ProductViewController {
    func configureUI() {
        addChildProductDetailInfoController()
        //        addChildFeedbackController()
    }
    
    func addChildProductDetailInfoController() {
        self.addChild(productDetailInfoController)
        productView.scrollView.addSubview(productDetailInfoController.view)
        self.productDetailInfoController.didMove(toParent: self)
        
        productDetailInfoController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productDetailInfoController.view.topAnchor
                .constraint(equalTo: productView.scrollView.topAnchor),
            productDetailInfoController.view.leftAnchor
                .constraint(equalTo: productView.safeAreaLayoutGuide.leftAnchor),
            productDetailInfoController.view.rightAnchor
                .constraint(equalTo: productView.safeAreaLayoutGuide.rightAnchor),
//            productDetailInfoController.view.heightAnchor
//                .constraint(equalToConstant: 1500)
            productDetailInfoController.view.bottomAnchor
                .constraint(equalTo: productView.scrollView.bottomAnchor),
        ])
    }
}
