//
//  ProfileData.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.04.2023.
//

import Foundation

typealias UserStatisticsArray = [(String, String)]

struct ProfileData {
    
    var user: User?
    var currentSkinData: Data?
    var userStatisticsArray: UserStatisticsArray?
    
}
