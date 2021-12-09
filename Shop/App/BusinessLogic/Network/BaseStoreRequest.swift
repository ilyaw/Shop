//
//  BaseStoreRequest.swift
//  Shop
//
//  Created by Ilya on 06.12.2021.
//

import Foundation
import Alamofire

class BaseStoreRequest: AbstractRequestFactory {
    
    var url: URL {
        URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    }
    
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
