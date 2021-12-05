//
//  MainViewController.swift
//  Shop
//
//  Created by Ilya on 02.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewOutput
    var requestFactory: RequestFactory
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: view.bounds)
        view.style = .large
        return view
    }()
    
    init(presenter: MainViewOutput,
         requestFactory: RequestFactory) {
        self.presenter = presenter
        self.requestFactory = requestFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        presenter.auth(userName: "Somebody", password: "mypassword")
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: MainViewInput

extension MainViewController: MainViewInput {
    
    func showError(error: Error) {
        showAlert(with: error.localizedDescription)
    }
    
    func showResult(result: LoginResult) {
        showAlert(with: "Hello, \(result.user.name)!" )
    }
}

// MARK: - SwiftUI

import SwiftUI

struct MainProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = MainViewController(presenter: MainPresenter(),
                                                requestFactory: RequestFactory())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainProvider.ContainerView>) -> MainViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: MainProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainProvider.ContainerView>) {
            
        }
    }
}
