//
//  PostGameStatistics.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 02.04.2023.
//

import Foundation

struct PlayerPostGameStatistics: Codable {
    
    var playerID: Int
    var username: String
    var skin: URL
    var rating: Int
    var isPro: Bool
    var currentQuestionIndex: Int
    var submissionTimestamp: Int?
    var place: Int
    var ratingDiff: Int?
    var balanceDiff: Int?
    
    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case username
        case skin
        case rating
        case isPro = "is_pro"
        case currentQuestionIndex = "current_question_index"
        case submissionTimestamp = "submission_timestamp"
        case place
        case ratingDiff = "rating_diff"
        case balanceDiff = "balance_diff"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerID = try container.decode(Int.self, forKey: .playerID)
        self.username = try container.decode(String.self, forKey: .username)
        
        let skinString = try container.decode(String.self, forKey: .skin)
        self.skin = URL(string: skinString)!
        
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.isPro = try container.decode(Bool.self, forKey: .isPro)
        self.currentQuestionIndex = try container.decode(Int.self, forKey: .currentQuestionIndex)
        self.submissionTimestamp = try container.decodeIfPresent(Int.self, forKey: .submissionTimestamp)
        self.place = try container.decode(Int.self, forKey: .place)
        self.ratingDiff = try container.decodeIfPresent(Int.self, forKey: .ratingDiff)
        self.balanceDiff = try container.decodeIfPresent(Int.self, forKey: .balanceDiff)
    }
}

struct PostGameStatistics: Codable {
    
    var statistics: [PlayerPostGameStatistics]
}
