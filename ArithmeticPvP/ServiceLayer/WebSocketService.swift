//
//  WebSocketService.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation
import Starscream


class WebSocketService: WebSocketDelegate {
    
    enum WebSocketServiceError: Error, LocalizedError {
        
        case waitingRoomInfoFetchError
        
        case unknownReceivedData
        
        case someErrorFromServer
        
        case fullWaitingRoom
        case competitorsNotFound
        case unknownCloseCode
    }
    
    enum ReceivedWaitingRoomData {
        case initial
        case data(WaitingRoomData)
        case next(WaitingRoomData)
    }
    
    enum ReceivedGameData {
        case initial
        case data(GameData)
        case next
    }
    
    enum ReceivedPostGameStatisticsData {
        case initial
        case data(PostGameStatisticsData)
    }
    
    enum ReceivedErrorData {
        case initial
        case error(WebSocketServiceError)
    }
    
    static let shared = WebSocketService()
    let baseURL = URL(string: "ws://188.225.75.244/game/ws/")!
    private var webSocket: WebSocket?
    
    var receivedWaitingRoomData: Observable<ReceivedWaitingRoomData> = Observable(.initial)
    var receivedGameData: Observable<ReceivedGameData> = Observable(.initial)
    var receivedPostGameStatisticsData: Observable<ReceivedPostGameStatisticsData> = Observable(.initial)
    var receivedErrorData: Observable<ReceivedErrorData> = Observable(.initial)
    
    
    func connectToWebSocket(with gameID: Int) {
        let gameURL = baseURL.appendingPathComponent("\(gameID)")
        
        var request = URLRequest(url: gameURL)
        
        guard let cookie = UserDefaultsHelper.shared.getCookie() else { return }
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        webSocket = WebSocket(request: request)
        webSocket?.delegate = self
        webSocket?.connect()
    }
    
    func disconnectFromWebSocket() {
        webSocket?.disconnect(closeCode: CloseCode.normal.rawValue)
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(_):
            NSLog("Websocket is connected")
        case .disconnected(_, let code):
            NSLog("Websocket is disconnected with code: \(code)")
            if code == 3000 {
                self.receivedErrorData.value = .error(.fullWaitingRoom)
            } else if code == 3003 {
                self.receivedErrorData.value = .error(.competitorsNotFound)
            } else {
                self.receivedErrorData.value = .error(.unknownCloseCode)
            }
        case .text(let receivedString):
            NSLog("Received text: \(receivedString)")
            parseReceivedData(receivedString: receivedString)
        case .binary(_):
            break
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            break
        case .error(let error):
            if let error = error {
                NSLog("\(error)")
            }
            self.receivedErrorData.value = .error(.someErrorFromServer)
        }
    }
    
    private func parseReceivedData(receivedString: String) {
        
        let data = Data(receivedString.utf8)
        
        if let waitingRoomInfo = try? JSONDecoder().decode(WaitingRoomInfo.self, from: data) {
            
            let waitingRoomData = WaitingRoomData(players: waitingRoomInfo.players, startTime: waitingRoomInfo.startTime)
            self.receivedWaitingRoomData.value = .data(waitingRoomData)
            
        } else if let insufficientPlayersAmountError =  try? JSONDecoder().decode(InsufficientPlayersAmountError.self, from: data) {
            
            if case .data(let lastWaitingRoomData) = self.receivedWaitingRoomData.value {
                let waitingRoomData = WaitingRoomData(players: lastWaitingRoomData.players, startTime: insufficientPlayersAmountError.newStartTime)
                self.receivedWaitingRoomData.value = .data(waitingRoomData)
            }
            
        } else if let nextQuestionEvent = try? JSONDecoder().decode(NextQuestionEvent.self, from: data) {
            
            if case .data(let lastWaitingRoomData) = self.receivedWaitingRoomData.value {
                self.receivedWaitingRoomData.value = .next(lastWaitingRoomData)
            }
            // ВОЗМОЖНО ЕРРОР, ЕСЛИ НЕТ lastWaitingRoomData
            
            if case .data(let lastGameData) = self.receivedGameData.value {
                let gameData = GameData(currentQuestion: nextQuestionEvent.message, currentAnswer: nil, currentPlayersProgress: lastGameData.currentPlayersProgress)
                self.receivedGameData.value = .data(gameData)
            } else {
                let gameData = GameData(currentQuestion: nextQuestionEvent.message, currentAnswer: nil, currentPlayersProgress: nil)
                self.receivedGameData.value = .data(gameData)
            }
            
        } else if let playersProgress = try? JSONDecoder().decode(PlayersProgress.self, from: data) {
            
            if case .data(let lastGameData) = self.receivedGameData.value {
                let gameData = GameData(currentQuestion: lastGameData.currentQuestion, currentAnswer: lastGameData.currentAnswer, currentPlayersProgress: playersProgress)
                self.receivedGameData.value = .data(gameData)
            }
            
        } else if receivedString == "{\"event\": \"finished\"}" {
            
            self.receivedGameData.value = .next
            
        } else if let postGameStatistics = try? JSONDecoder().decode(PostGameStatistics.self, from: data) {
            
            let postGameStatisticsData = PostGameStatisticsData(postGameStatistics: postGameStatistics)
            self.receivedPostGameStatisticsData.value = .data(postGameStatisticsData)
            
        } else if receivedString == "{\"error\": \"game_is_not_started\", \"message\": \"Game isn't started yet\"}" {
            self.sendData(message: "{\"event\": \"start_game\"}")
        } else {
            self.receivedErrorData.value = .error(.unknownReceivedData)
        }
    }
    
    func sendData(message: String) {
        webSocket?.write(string: message)
        NSLog("Send data: \(message)")
    }
    
}
