//
//  CurrentSkin.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation

struct CurrentSkin: Codable {
    
    var name: String
    var imageURL: URL
    var id: Int
    
    init(name: String, imageURL: URL = URL(string: "www.apple.com")!, id: Int) {
        self.name = name
        self.imageURL = imageURL
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        let stringImageURL = try container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: stringImageURL)!
        
        self.id = try container.decode(Int.self, forKey: .id)
    }
}
