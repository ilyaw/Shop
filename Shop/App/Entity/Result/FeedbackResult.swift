//
//  FeedbackResult.swift
//  Shop
//
//  Created by Ilya on 17.12.2021.
//

import Foundation

struct FeedbackResult: Codable {
    let result: Int
    let feedback: [Feedback]
}

struct Feedback: Codable {
    let text, date, profilePicture, fullName: String
    let feedbackId: Int
}
