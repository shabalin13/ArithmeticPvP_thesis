//
//  ProfileViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var state: Observable<ProfileState> { get set }
    var router: ProfileRouterProtocol { get set }
    
    func updateState()
    var profileData: ProfileData { get set }
    func getProfileData(cookie: String)
    
    func goToSettings()
    func goToSignIn()
    
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    // MARK: - ProfileViewModel properties
    var state: Observable<ProfileState> = Observable(.initial)
    var router: ProfileRouterProtocol
    
    var profileData = ProfileData()
    
    // MARK: - Init
    init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Profile state checking
    func updateState() {
        if let cookie = UserDefaultsHelper.shared.getCookie() {
            getProfileData(cookie: cookie)
        } else {
            self.state.value = .notRegistered
        }
    }
    
    // MARK: - Func for getting Profile Data for the current user
    func getProfileData(cookie: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            NetworkService.shared.getUserInfo(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.profileData = ProfileData(user: user, currentSkinData: self.profileData.currentSkinData, userStatisticsArray: self.profileData.userStatisticsArray)
                    NSLog("Profile Data: \(self.profileData)")
                    self.state.value = .registered(self.profileData)
                    
                    NetworkService.shared.getSkinImage(from: user.currentSkin.imageURL) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let imageData):
                            self.profileData = ProfileData(user: self.profileData.user, currentSkinData: imageData, userStatisticsArray: self.profileData.userStatisticsArray)
                            NSLog("Profile Data: \(self.profileData)")
                            self.state.value = .registered(self.profileData)
                            
                            NetworkService.shared.getUserStatistics(cookie: cookie) { [weak self] result in
                                guard let self = self else { return }
                                switch result {
                                case .success(let userStatistics):
                                    
                                    var userStatisticsArray = UserStatisticsArray()
                                    userStatisticsArray.append(("Rating Place", "\(userStatistics.ratingPlace)"))
                                    userStatisticsArray.append(("Games Played", "\(userStatistics.gamesPlayed)"))
                                    
                                    let timePlayedComponents = self.helper(time: userStatistics.timePlayed)
                                    userStatisticsArray.append(("Time Played", "\(timePlayedComponents.0)d \(timePlayedComponents.1)h \(timePlayedComponents.2)m"))
                                    
                                    userStatisticsArray.append(("Tasks Solved", "\(userStatistics.tasksSolved)"))
                                    
                                    if let bestGameTime = userStatistics.bestGameTime {
                                        let bestGameTimeComponents = self.helper(time: bestGameTime)
                                        userStatisticsArray.append(("Best Game Time", "\(bestGameTimeComponents.2)m \(bestGameTimeComponents.3)s"))
                                    } else {
                                        userStatisticsArray.append(("Best Game Time", "-"))
                                    }
                                    
                                    self.profileData = ProfileData(user: self.profileData.user, currentSkinData: self.profileData.currentSkinData, userStatisticsArray: userStatisticsArray)
                                    NSLog("Profile Data: \(self.profileData)")
                                    self.state.value = .registered(self.profileData)
                                    
                                case .failure(let error):
                                    self.state.value = .error(error)
                                }
                            }
                        case .failure(let error):
                            self.state.value = .error(error)
                        }
                    }
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    private func helper(time: Int) -> (Int, Int, Int, Int) {
        let seconds = time / 1000
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24

        let remainingSeconds = seconds % 60
        let remainingMinutes = minutes % 60
        let remainingHours = hours % 24
        
        return (days, remainingHours, remainingMinutes, remainingSeconds)
    }
    
    func goToSettings() {
        router.showSettings()
    }
    
    func goToSignIn() {
        router.showSignIn()
    }
    
}
