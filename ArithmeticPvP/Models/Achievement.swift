//
//  Achievement.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 24.03.2023.
//

import Foundation

struct Achievement: Codable {
    
    var id: Int
    var title: String
    var description: String
    var type: String
    var progressLimit: Double
    var progress: Double
    var isReceived: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case type
        case progressLimit = "progress_limit"
        case progress
        case isReceived = "is_received"
    }
}
