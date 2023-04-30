//
//  CurrentSkin.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation

struct CurrentSkin: Codable {
    
    var id: Int
    var name: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        let stringImageURL = try container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: stringImageURL)!
    }
}
