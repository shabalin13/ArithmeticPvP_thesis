//
//  WaitingRoomInfo.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation

struct WaitingRoomInfo: Codable {
    
    var players: [Player]
    var startTime: Date
    
    enum CodingKeys: String, CodingKey {
        case players
        case startTime = "start_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.players = try container.decode([Player].self, forKey: .players)
        
        let startTimeDouble = try container.decode(Double.self, forKey: .startTime)
        self.startTime = Date(timeIntervalSince1970: startTimeDouble / 1000)
    }
    
}
