//
//  Statistics.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation

struct Statistics: Codable, CustomStringConvertible {
    
    var username: String
    var ratingPlace: Int
    var isPro: Bool
    var currentSkin: CurrentSkin
    var gamesPlayed: Int
    var timePlayed: Int
    var tasksSolved: Int
    var bestGameTime: Int?
    
    var description: String {
        return "Statistics(username: \(username), ratingPlace: \(ratingPlace), isPro: \(isPro), currentSkin: \(currentSkin), gamesPlayed: \(gamesPlayed), timePlayed: \(timePlayed), tasksSolved: \(tasksSolved), bestGameTime: \(bestGameTime)"
    }
    
    enum CodingKeys: String, CodingKey {
        case username
        case ratingPlace = "rating_place"
        case isPro
        case currentSkin = "current_skin"
        case gamesPlayed = "games_played"
        case timePlayed = "time_played"
        case tasksSolved = "tasks_solved"
        case bestGameTime = "best_game_time"
    }
    
}
