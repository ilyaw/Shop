//
//  BaseStoreRequest.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation
import Alamofire

// Local: http://127.0.0.1:8080/
// Hosting: https://secret-everglades-22465.herokuapp.com/

class BaseURL {
    var url: URL { URL(string: "https://secret-everglades-22465.herokuapp.com/")! }
}

class BaseStoreRequest: BaseURL, AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}
