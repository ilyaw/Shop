//
//  RequestFactroy.swift
//  Shop
//
//  Created by Ilya on 05.12.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeLogoutRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
}
