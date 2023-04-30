//
//  User.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation

struct User: Codable {
    
    var username: String
    var email: String
    var rating: Int
    var balance: Int
    var isPro: Bool
    var currentSkin: CurrentSkin
    var ratingPlace: Int
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case rating
        case balance
        case isPro
        case currentSkin = "current_skin"
        case ratingPlace = "rating_place"
    }
    
}
