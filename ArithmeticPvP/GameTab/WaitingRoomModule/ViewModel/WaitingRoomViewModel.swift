//
//  WaitingRoomViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import Foundation

protocol WaitingRoomViewModelProtocol {
    
    var state: Observable<WaitingRoomState> { get set }
    var router: GameRouterProtocol { get set }
    
    func update()
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData)
    func updateData(for receivedData: WebSocketService.ReceivedWaitingRoomData)
    
    func getSkinImage(from url: URL, completion: @escaping (Data) -> Void)
    
    func getWaitingRoomInfo()
    func connectToWS(with gameID: Int)
    func startGame()
    func exit(with error: WebSocketService.WebSocketServiceError?)
}

class WaitingRoomViewModel: WaitingRoomViewModelProtocol {
    
    // MARK: - Class Properties
    var state: Observable<WaitingRoomState> = Observable(.initial)
    var router: GameRouterProtocol
    
    private var startGameTimer: Timer?
    private var startGameTime: Date?
    
    // MARK: - Init
    init(router: GameRouterProtocol) {
        self.router = router
        
        bindReceivedData()
    }
    
    // MARK: - ReceivedData binding and unbinding
    private func bindReceivedData() {
        WebSocketService.shared.receivedWaitingRoomData.bind { [weak self] receivedData in
            guard let self = self else { return }
            self.updateData(for: receivedData)
        }
        
        WebSocketService.shared.receivedErrorData.bind { [weak self] receivedErrorData in
            guard let self = self else { return }
            self.updateError(for: receivedErrorData)
        }
    }
    
    private func unbindReceivedData() {
        WebSocketService.shared.receivedWaitingRoomData.bind { _ in }
        WebSocketService.shared.receivedErrorData.bind { _ in }
    }
    
    // MARK: - Updating data and error
    func update() {
        self.updateData(for: WebSocketService.shared.receivedWaitingRoomData.value)
        self.updateError(for: WebSocketService.shared.receivedErrorData.value)
    }
    
    // MARK: - Updating after receiving error data
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData) {
        NSLog("WaitingRoomViewModel: updateError")
        if case .error(let error) = receivedErrorData {
            self.state.value = .error(error)
        }
    }
    
    // MARK: - Updating after receiving new data
    func updateData(for receivedData: WebSocketService.ReceivedWaitingRoomData) {
        NSLog("WaitingRoomViewModel: updateData")
        
        switch receivedData {
        case .initial:
            self.state.value = .initial
            
        case .data(let waitingRoomData):
            
            if (self.startGameTime != nil && waitingRoomData.startTime != self.startGameTime!) || self.startGameTime == nil {
                self.startGameTime = waitingRoomData.startTime
                self.startGameTimer?.invalidate()
                self.startGameTimer = Timer(fireAt: waitingRoomData.startTime, interval: 0, target: self, selector: #selector(self.startGame), userInfo: nil, repeats: false)
                RunLoop.main.add(self.startGameTimer!, forMode: .common)
            }
            
            self.state.value = .data(waitingRoomData)
            
        case .next(let waitingRoomData):
            unbindReceivedData()
            DispatchQueue.main.async {
                self.router.startGame(players: waitingRoomData.players)
            }
        }
        
    }
    
    // MARK: - Func for getting Skin Image of the Player
    func getSkinImage(from url: URL, completion: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            NetworkService.shared.getSkinImage(from: url) { result in
                if case .success(let imageData) = result {
                    completion(imageData)
                }
            }
        }
    }
    
    // MARK: - Func for getting WaitingRoomInfo
    func getWaitingRoomInfo() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            guard let cookie = UserDefaultsHelper.shared.getCookie() else {
                self.state.value = .error(WebSocketService.WebSocketServiceError.waitingRoomInfoFetchError)
                return
            }
            NetworkService.shared.getWaitingRoomInfo(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let waitingRoomStartInfo):
                    NSLog("waitingRoomStartInfo: \(waitingRoomStartInfo)")
                    self.connectToWS(with: waitingRoomStartInfo.id)
                case .failure(_):
                    self.state.value = .error(WebSocketService.WebSocketServiceError.waitingRoomInfoFetchError)
                }
            }
        }
    }
    
    // MARK: - Func for connecting to WebSocket
    func connectToWS(with gameID: Int) {
        DispatchQueue.global().async {
            WebSocketService.shared.connectToWebSocket(with: gameID)
        }
    }
    
    // MARK: - Func for starting the Game
    @objc func startGame() {
        DispatchQueue.global().async {
            WebSocketService.shared.sendData(message: "{\"event\": \"start_game\"}")
        }
    }
    
    // MARK: - Func to exit from Waiting Room
    func exit(with error: WebSocketService.WebSocketServiceError?) {
        self.unbindReceivedData()
        WebSocketService.shared.receivedGameData = Observable(.initial)
        WebSocketService.shared.receivedPostGameStatisticsData = Observable(.initial)
        WebSocketService.shared.receivedErrorData = Observable(.initial)
        self.startGameTimer?.invalidate()
        
        WebSocketService.shared.disconnectFromWebSocket()
        NSLog("ViewModel disconnected")
        
        if let error = error, error == .fullWaitingRoom {
            bindReceivedData()
            getWaitingRoomInfo()
            // router.goToWaitingRoomAgain()
        } else {
            router.backToPrevious()
        }
    }
    
}
