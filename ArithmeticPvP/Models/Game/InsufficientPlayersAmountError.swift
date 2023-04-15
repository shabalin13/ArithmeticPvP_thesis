//
//  InsufficientPlayersAmountError.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 01.04.2023.
//

import Foundation

struct InsufficientPlayersAmountError: Codable {
    
    var error: String
    var newStartTime: Date
    
    enum CodingKeys: String, CodingKey {
        case error
        case newStartTime = "new_start_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try container.decode(String.self, forKey: .error)
        
        let newStartTimeDouble = try container.decode(Double.self, forKey: .newStartTime)
        self.newStartTime = Date(timeIntervalSince1970: newStartTimeDouble / 1000)
    }
}
