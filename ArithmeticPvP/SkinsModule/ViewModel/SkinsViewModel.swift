//
//  SkinsViewModel.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import Foundation

protocol SkinsViewModelProtocol {
    
    var state: Observable<SkinsState> { get set }
    var router: SkinsRouterProtocol { get set }
    
    var skins: [Skin] { get set }
    var ownedSkins: [Skin] { get }
    var balance: Double { get set }
    var currentSkin: Skin? { get set }
    
    func updateState()
    func getSkinsList(cookie: String)
    func getSkinImage(from url: URL, completion: @escaping (Data) -> Void)
    func getUserBalance(cookie: String)
    
    func selectSkin(with id: Int, completion: @escaping (Bool) -> Void)
    func buySkin(with id: Int, completion: @escaping (Bool) -> Void)
}

class SkinsViewModel: SkinsViewModelProtocol {
    
    // MARK: - Class properties
    var state: Observable<SkinsState> = Observable(.initial)
    var router: SkinsRouterProtocol
    
    var skins = [Skin]()
    var ownedSkins: [Skin] {
        return skins.filter { skin in
            skin.isOwner
        }
    }
    var balance: Double = 0
    var currentSkin: Skin?
    
    // MARK: - Init
    init(router: SkinsRouterProtocol) {
        self.router = router
    }
    
    // MARK: - Updating state
    func updateState() {
        if let cookie = UserDefaultsHelper.shared.getCookie() {
            getSkinsList(cookie: cookie)
            getUserBalance(cookie: cookie)
        } else {
            self.state.value = .notRegistered
        }
    }
    
    // MARK: - Func for getting list of skins
    func getSkinsList(cookie: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.state.value = .loading
            NetworkService.shared.getSkinsList(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let skins):
                    self.skins = skins
                    self.state.value = .registered
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    // MARK: - Func for getting user balance
    func getUserBalance(cookie: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            NetworkService.shared.getUserBalance(cookie: cookie) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let balance):
                    self.balance = balance
                    self.state.value = .registered
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    // MARK: - Func for getting skin image for the user
    func getSkinImage(from url: URL, completion: @escaping (Data) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            NetworkService.shared.getSkinImage(from: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    self.state.value = .error(error)
                }
            }
        }
    }
    
    // MARK: - Func for selecting skin for the user
    func selectSkin(with id: Int, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {[weak self] in
            guard let self = self else { return }
            if let cookie = UserDefaultsHelper.shared.getCookie() {
                NetworkService.shared.selectSkin(cookie: cookie, id: id) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let isTrue):
                        completion(isTrue)
                    case .failure(let error):
                        self.state.value = .error(error)
                    }
                }
            }
        }
    }
    
    // MARK: - Func for buying skin for the user
    func buySkin(with id: Int, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let cookie = UserDefaultsHelper.shared.getCookie() {
                NetworkService.shared.buySkin(cookie: cookie, id: id) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let isTrue):
                        completion(isTrue)
                    case .failure(let error):
                        self.state.value = .error(error)
                    }
                }
            }
        }
    }
    
}
