//
//  States.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import Foundation
import UIKit

// MARK: - Profile
enum ProfileState {
    case initial
    case loading
    case registered(ProfileData)
    case notRegistered
    case error(NetworkService.NetworkServiceError)
}

enum SignInState {
    case initial
    case loading
    case notRegistered
    case error(Error)
}

enum SettingsState {
    case initial
    case loading
    case registered(SettingsData)
    case notRegistered
    case error(Error)
}

// MARK: - Skins
enum SkinsState {
    case initial
    case loading
    case registered
    case notRegistered
    case error(NetworkService.NetworkServiceError)
}

// MARK: - Rating Game
enum StartGameState {
    case initial
    case registered
    case notRegistered
}

enum WaitingRoomState {
    case initial
    case loading
    case data(WaitingRoomData)
    case error(WebSocketService.WebSocketServiceError)
}

enum GameState {
    case initial
    case incorrectData(GameData)
    case data(GameData)
    case error(WebSocketService.WebSocketServiceError)
}

enum PostGameStatisticsState {
    case initial
    case data(PostGameStatisticsData)
    case error(WebSocketService.WebSocketServiceError)
}
