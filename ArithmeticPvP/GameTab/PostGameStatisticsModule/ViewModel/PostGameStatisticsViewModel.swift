//
//  PostGameStatisticsViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import Foundation

protocol PostGameStatisticsViewModelProtocol {
    
    var state: Observable<PostGameStatisticsState> { get set }
    var router: GameRouterProtocol { get set }
    
    func update()
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData)
    func updateData(for receivedData: WebSocketService.ReceivedPostGameStatisticsData)
    
    func getSkinImage(from url: URL, completion: @escaping (Data) -> Void)
    func exit(with error: WebSocketService.WebSocketServiceError?)
}

class PostGameStatisticsViewModel: PostGameStatisticsViewModelProtocol {
    
    // MARK: - Class Properties
    var state: Observable<PostGameStatisticsState> = Observable(.initial)
    var router: GameRouterProtocol
    
    // MARK: - Init
    init(router: GameRouterProtocol) {
        self.router = router
        
        bindReceivedData()
    }
    
    // MARK: - ReceivedData binding and unbinding
    private func bindReceivedData() {
        WebSocketService.shared.receivedPostGameStatisticsData.bind { [weak self] receivedData in
            guard let self = self else { return }
            self.updateData(for: receivedData)
        }
        
        WebSocketService.shared.receivedErrorData.bind { [weak self] receivedErrorData in
            guard let self = self else { return }
            self.updateError(for: receivedErrorData)
        }
    }
    
    private func unbindReceivedData() {
        WebSocketService.shared.receivedPostGameStatisticsData.bind { _ in return }
        WebSocketService.shared.receivedErrorData.bind { _ in return }
    }
    
    // MARK: - Updating data and error
    func update() {
        self.updateData(for: WebSocketService.shared.receivedPostGameStatisticsData.value)
        self.updateError(for: WebSocketService.shared.receivedErrorData.value)
    }
    
    // MARK: - Updating after receiving error data
    func updateError(for receivedErrorData: WebSocketService.ReceivedErrorData) {
        NSLog("PostGameStatisticsViewModel: updateError")
        if case .error(let error) = receivedErrorData {
            self.state.value = .error(error)
        }
    }
    
    // MARK: - Updating after receiving new data
    func updateData(for receivedData: WebSocketService.ReceivedPostGameStatisticsData) {
        
        NSLog("PostGameStatisticsViewModel: updateData")
        
        switch receivedData {
        case .initial:
            self.state.value = .initial
            
        case .data(let postGameStatisticsData):
            
            let filteredStatistics = postGameStatisticsData.postGameStatistics.statistics.filter { playerPostGameStatistics in
                playerPostGameStatistics.ratingDiff != nil
            }
            
            let filteredSortedStatistics = filteredStatistics.sorted { playerPostGameStatistics1, playerPostGameStatistics2 in
                playerPostGameStatistics1.place < playerPostGameStatistics2.place
            }
            
            let filteredSortedPostGameStatisticsData = PostGameStatisticsData(postGameStatistics: PostGameStatistics(statistics: filteredSortedStatistics))
            
            self.state.value = .data(filteredSortedPostGameStatisticsData)
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
    
    // MARK: - Func to exit from Post Game Statistics
    func exit(with error: WebSocketService.WebSocketServiceError?) {
        self.unbindReceivedData()
        WebSocketService.shared.receivedGameData = Observable(.initial)
        WebSocketService.shared.receivedPostGameStatisticsData = Observable(.initial)
        WebSocketService.shared.receivedErrorData = Observable(.initial)
        
        WebSocketService.shared.disconnectFromWebSocket()
        NSLog("PostGameStatisticsViewModel disconnected")
        
        if let error = error {
            router.popToRoot()
        } else {
            router.popToRoot()
        }
    }
    
}
