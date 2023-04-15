//
//  PlayersProgress.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 02.04.2023.
//

import Foundation

struct PlayerProgress: Codable {
    
    var id: Int
    var progress: Int

}

struct PlayersProgress: Codable {
    
    var tasksAmount: Int
    var players: [PlayerProgress]
    
    enum CodingKeys: String, CodingKey {
        case tasksAmount = "tasks_amount"
        case players
    }
    
}
