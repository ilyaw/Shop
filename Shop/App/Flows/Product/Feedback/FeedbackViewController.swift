//
//  FeedbackViewController.swift
//  Shop
//
//  Created by Ilya on 01.02.2022.
//

import UIKit

class FeedbackViewController: UIViewController, ViewSpecificController {
    typealias RootView = FeedbackView
    
    // MARK: - Inits
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = FeedbackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - FeedbackViewController + private extension

private extension FeedbackViewController {
    
}
