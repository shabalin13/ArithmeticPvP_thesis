//
//  Skin.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation

struct Skin: Codable {
    
    var id: Int
    var name: String
    var description: String
    var price: Double
    var imageURL: URL
    var isOwner: Bool
    var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageURL = "image_url"
        case isOwner = "is_owner"
        case isSelected = "is_selected"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Double.self, forKey: .price)
        
        let stringImageURL = try container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: stringImageURL)!
        
        self.isOwner = try container.decode(Bool.self, forKey: .isOwner)
        self.isSelected = try container.decode(Bool.self, forKey: .isSelected)
    }
}
