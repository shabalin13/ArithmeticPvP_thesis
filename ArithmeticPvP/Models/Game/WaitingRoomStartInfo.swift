//
//  WaitingRoomStartInfo.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation

struct WaitingRoomStartInfo: Codable {
    
    var id: Int
    var amountOfPlayers: Int
    var startTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case amountOfPlayers = "amount_of_players"
        case startTime = "start_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.amountOfPlayers = try container.decode(Int.self, forKey: .amountOfPlayers)
        
        let startTimeDouble = try container.decode(Double.self, forKey: .startTime)
        self.startTime = Date(timeIntervalSince1970: startTimeDouble / 1000)
    }
    
}
