//
//  AuthViewController.swift
//  Shop
//
//  Created by Ilya on 02.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    var presenter: MainViewOutput
    var requestFactory: RequestFactory
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: view.bounds)
        view.style = .large
        return view
    }()
    
    init(presenter: MainViewOutput, requestFactory: RequestFactory) {
        self.presenter = presenter
        self.requestFactory = requestFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        presenter.auth(userName: "Somebody", password: "mypassword")
//        presenter.logout(userId: 123)
//
//        // TODO: Позже вынесу в отдельный класс
//
//        // MARK: User Request
//        let userRequest = requestFactory.makeUserRequestFactory()
//        let profileModel = generateProfile()
//
//        userRequest.register(for: profileModel) { response in
//            switch response.result {
//            case .success(let register):
//                print("Регистрация: \(register.userMessage)")
//            case .failure(let error):
//                print("Error register: \(error.localizedDescription)")
//            }
//        }
//
//        userRequest.change(for: profileModel) { response in
//            switch response.result {
//            case .success(let change):
//                print("Change: \(change.result)")
//            case .failure(let error):
//                print("Error change: \(error.localizedDescription)")
//            }
//        }
        
        // MARK: Product Request
        
//        let productRequest = requestFactory.makeProductRequestFactory()
//        
//        productRequest.getCatalog(numberPage: 1, categoryId: 1) { response in
//            switch response.result {
//            case .success(let catalog):
//               let _ = catalog.map { print("\($0.productName) за \($0.price) руб.") }
//            case .failure(let error):
//                print("Error getCatalog: \(error.localizedDescription)")
//            }
//        }
//        
//        productRequest.getProductById(productId: 123) { response in
//            switch response.result {
//            case .success(let product):
//                print("Продукт: \(product.productName)\nОписание: \(product.productDescription)")
//            case .failure(let error):
//                print("Error getProductById: \(error.localizedDescription)")
//            }
//        }
    }
    
    // TODO: Позже вынесу в отдельный класс
    
    private func generateProfile() -> ProfileResult {
        ProfileResult(userId: 123,
                login: "Somebody",
                password: "mypassword",
                email: "some@some.ru",
                gender: "m",
                creditCard: "9872389-2424-234224-234",
                bio: "This is good! I think I will switch to another language")
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

extension AuthViewController: MainViewInput {
    
    func showError(error: Error) {
        showAlert(with: error.localizedDescription)
    }
    
    func showLoginResult(result: LoginResult) {
        showAlert(with: "Hello, \(result.user.firstName)!" )
    }
    
    func showLogoutResult(result: LogoutResult) {
        showAlert(with: "Logout result is \(result.result)" )
    }
}

// MARK: - SwiftUI

import SwiftUI

struct MainProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController(presenter: AuthPresenter(),
                                                requestFactory: RequestFactory())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: MainProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainProvider.ContainerView>) {
        }
    }
}
