//
//  NextQuestionEvent.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 01.04.2023.
//

import Foundation

struct NextQuestionEvent: Codable {
    
    var event: String
    var message: Question
    
}
