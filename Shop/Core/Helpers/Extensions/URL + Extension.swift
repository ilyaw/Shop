//
//  URL + Extension.swift
//  Shop
//
//  Created by Ilya on 04.01.2022.
//

import Foundation

extension URL {
    func сheckWebsiteAvailability(completion: @escaping (Bool) -> Void) {
        let url = self
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if error != nil {
                completion(false)
            }
            if (response as? HTTPURLResponse) != nil {
                completion(true)
            }
        }
        
        task.resume()
    }
}

extension Optional where Wrapped == URL {
    func сheckWebsiteAvailability(completion: @escaping (Bool) -> Void) {
        guard let url = self else { return }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10.0
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if error != nil {
                completion(false)
            }
            if (response as? HTTPURLResponse) != nil {
                completion(true)
            }
        }
        
        task.resume()
    }
}
