//
//  GameViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation

protocol GameViewModelProtocol {
    
    var state: Observable<GameState> { get set }
    var router: GameRouterProtocol { get set }
    
    var players: [Player] { get set }
    var currentAnswer: String? { get set }
    
    func update()
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData)
    func updateData(for receivedData: WebSocketService.ReceivedGameData)
    
    func keyboardButtonTapped(buttonTitle: String)
    func submitAnswer(answer: String)
    func exitGame(with error: WebSocketService.WebSocketServiceError?)
}

class GameViewModel: GameViewModelProtocol {
    
    // MARK: - Class Properties
    var router: GameRouterProtocol
    var state: Observable<GameState> = Observable(.initial)

    var players: [Player]
    var currentAnswer: String?
    
    // MARK: - Init
    init(router: GameRouterProtocol, players: [Player]) {
        self.router = router
        self.players = players

        bindReceivedData()
    }
    
    // MARK: - ReceivedData binding and unbinding
    private func bindReceivedData() {
        WebSocketService.shared.receivedGameData.bind { [weak self] receivedData in
            guard let self = self else { return }
            self.updateData(for: receivedData)
        }
        
        WebSocketService.shared.receivedErrorData.bind { [weak self] receivedErrorData in
            guard let self = self else { return }
            self.updateError(for: receivedErrorData)
        }
    }
    
    private func unbindReceivedData() {
        WebSocketService.shared.receivedGameData.bind { _ in return }
        WebSocketService.shared.receivedErrorData.bind { _ in return }
    }
    
    // MARK: - Updating data and error
    func update() {
        self.updateData(for: WebSocketService.shared.receivedGameData.value)
        self.updateError(for: WebSocketService.shared.receivedErrorData.value)
    }
    
    // MARK: - Updating after receiving error data
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData) {
        NSLog("GameViewModel: updateError")
        if case .error(let error) = receivedErrorData {
            self.state.value = .error(error)
        }
    }
    
    // MARK: - Updating after receiving new data
    func updateData(for receivedData: WebSocketService.ReceivedGameData) {
        
        NSLog("GameViewModel: updateData")
        
        switch receivedData {
        case .initial:
            self.state.value = .initial
        case .data(let gameData):
            self.currentAnswer = gameData.currentAnswer
            self.state.value = .data(gameData)
        case .next:
            unbindReceivedData()
            DispatchQueue.main.async {
                self.router.showPostGameStatistics()
            }
        }
    }
    
    // MARK: - Func for submitting answer
    func submitAnswer(answer: String) {
        DispatchQueue.global().async {
            WebSocketService.shared.sendData(message: "{\"event\": \"submit\", \"answer\": \"\(answer)\"}")
        }
    }
    
    // MARK: - Func for parsing inputs from keyboard
    func keyboardButtonTapped(buttonTitle: String) {
        if case .data(let lastGameData) = WebSocketService.shared.receivedGameData.value {
            if buttonTitle == "Del" {
                
                if let currentAnswer = self.currentAnswer, currentAnswer.count > 1 {
                    self.currentAnswer!.removeLast()
                } else if let currentAnswer = self.currentAnswer, currentAnswer.count == 1 {
                    self.currentAnswer = nil
                }
                
                let gameData = GameData(currentQuestion: lastGameData.currentQuestion, currentAnswer: self.currentAnswer, currentPlayersProgress: lastGameData.currentPlayersProgress)
                WebSocketService.shared.receivedGameData.value = .data(gameData)
                
            } else {
                
                if let currentAnswer = self.currentAnswer {
                    if currentAnswer.count < lastGameData.currentQuestion.answer.count {
                        self.currentAnswer = self.currentAnswer! + buttonTitle
                    }
                } else {
                    self.currentAnswer = buttonTitle
                }
                
                let gameData = GameData(currentQuestion: lastGameData.currentQuestion, currentAnswer: self.currentAnswer, currentPlayersProgress: lastGameData.currentPlayersProgress)
                WebSocketService.shared.receivedGameData.value = .data(gameData)
                
                if let currentAnswer = self.currentAnswer  {
                    if currentAnswer == lastGameData.currentQuestion.answer {
                        self.submitAnswer(answer: currentAnswer)
                    } else if currentAnswer.count == lastGameData.currentQuestion.answer.count {
                        self.state.value = .incorrectData(gameData)
                    }
                }
            }
        }
    }
    
    // MARK: - Func to exit from Game
    func exitGame(with error: WebSocketService.WebSocketServiceError?) {
        self.unbindReceivedData()
        WebSocketService.shared.receivedGameData = Observable(.initial)
        WebSocketService.shared.receivedPostGameStatisticsData = Observable(.initial)
        WebSocketService.shared.receivedErrorData = Observable(.initial)
        
        WebSocketService.shared.disconnectFromWebSocket()
        NSLog("GameViewModel disconnected")
        
        if let error = error {
            router.popToRoot()
        } else {
            router.popToRoot()
        }
        
    }
    
}
