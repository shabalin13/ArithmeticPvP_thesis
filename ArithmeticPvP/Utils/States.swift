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
    case registered(User)
    case notRegistered
    case error(Error)
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
    case registered
    case notRegistered
    case error(Error)
}

// MARK: - Skins
enum SkinsState {
    case initial // изначальный пустой белый вью
    case loading // когда идет запрос в интернет,то показывается колесико загрузки
    case registered // если запрос успешен, то передаются лист всех скинов и вью контроллер их показывает
    case notRegistered // если нет куки, то экран, показывающий, что сначала нужно зарегистрироваться
    case error(NetworkService.NetworkServiceError) // еррор на весь экран (оборвался интернет, или куки исчерпан)
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
//    case loading
    case incorrectData(GameData)
    case data(GameData)
    case error(WebSocketService.WebSocketServiceError)
}

enum PostGameStatisticsState {
    case initial
    case data(PostGameStatisticsData)
    case error(WebSocketService.WebSocketServiceError)
}
