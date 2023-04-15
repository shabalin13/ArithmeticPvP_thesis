//
//  Player.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation

struct Player: Codable {
    
    var id: Int
    var username: String
    var skin: URL
    var isPro: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case skin
        case isPro = "is_pro"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
        
        let skinString = try container.decode(String.self, forKey: .skin)
        self.skin = URL(string: skinString)!
        
        self.isPro = try container.decode(Bool.self, forKey: .isPro)
    }
}
