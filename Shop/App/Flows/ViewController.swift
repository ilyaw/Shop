//
//  ViewController.swift
//  Shop
//
//  Created by Ilya on 02.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth(userName: "Somebody", password: "mypassword")
    }
    
    func auth(userName: String, password: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.login(userName: userName, password: password) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
