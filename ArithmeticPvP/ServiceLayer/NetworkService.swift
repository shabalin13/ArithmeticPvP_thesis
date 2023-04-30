//
//  NetworkService.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import Foundation
import FirebaseAuth

class NetworkService {
    
    enum NetworkServiceError: Error, LocalizedError {
        
        case authError
        
        case loginRequestFailed
        case logoutRequestFailed
        case refreshTokenRequestFailed
        
        case userInfoRequestFailed
        case userStatisticsRequestFailed
        case usernameChangeRequestFailed
        case userAchievementsRequestFailed
        
        case skinsListRequestFailed
        case skinSelectionRequestFailed
        case skinBuyingRequestFailed
        case userBalanceRequestFailed
        
        case waitingRoomInfoRequestFailed
        
        case imageDataMissing
    }
    
    static let shared = NetworkService()
    
    let baseURL = URL(string: "http://188.225.75.244/")!
    
    
    // MARK: - Authorization
    func logIn(idToken: String, completion: @escaping (Result<Void, NetworkServiceError>) -> Void) {
        
        let loginURL = baseURL.appendingPathComponent("user/login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(idToken)", forHTTPHeaderField: "authorization")
        
        NSLog("idToken: \(idToken)")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.loginRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let cookieString =  httpResponse.allHeaderFields["Set-Cookie"] as? String else {
                completion(.failure(.loginRequestFailed))
                return
            }
            
            let cookieArray = cookieString.components(separatedBy: "; ")
            guard cookieArray[0].hasPrefix("session=") else {
                completion(.failure(.loginRequestFailed))
                return
            }
            
            guard cookieArray[1].hasPrefix("expires=") else {
                completion(.failure(.loginRequestFailed))
                return
            }
            
            let cookie = cookieArray[0].replacingOccurrences(of: "session=", with: "")
            let expiryDateString = cookieArray[1].replacingOccurrences(of: "expires=", with: "")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            guard let expiryDate = dateFormatter.date(from: expiryDateString) else {
                completion(.failure(.loginRequestFailed))
                return
            }
            
            UserDefaultsHelper.shared.setCookie(cookie)
            UserDefaultsHelper.shared.setExpiryDate(expiryDate)
            NSLog("cookie: \(cookie), expiryDate: \(expiryDate)")
            completion(.success(()))
        }
        task.resume()
    }
    
    func logOut(completion: @escaping (Result<Void, NetworkServiceError>) -> Void) {
        
        guard let cookie = UserDefaultsHelper.shared.getCookie() else {
            completion(.failure(.logoutRequestFailed))
            return
        }
        
        let logoutURL = baseURL.appendingPathComponent("user/logout")
        var request = URLRequest(url: logoutURL)
        request.httpMethod = "POST"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.logoutRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.logoutRequestFailed))
                return
            }
            
            UserDefaultsHelper.shared.removeCookie()
            UserDefaultsHelper.shared.removeExpiryDate()
            completion(.success(()))
        }
        task.resume()
    }
    
    func refreshToken(completion: @escaping (Result<Void, NetworkServiceError>) -> Void) {
        
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { idToken, error in
            if error != nil {
                completion(.failure(.refreshTokenRequestFailed))
                return
            } else if let idToken = idToken {
                let refreshTokenURL = self.baseURL.appendingPathComponent("user/refresh-session")
                
                var request = URLRequest(url: refreshTokenURL)
                request.httpMethod = "POST"
                request.setValue("Bearer \(idToken)", forHTTPHeaderField: "authorization")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    if let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 401 {
                        completion(.failure(.authError))
                        UserDefaultsHelper.shared.removeCookie()
                        UserDefaultsHelper.shared.removeExpiryDate()
                        return
                    }
                    
                    if let _ = error {
                        completion(.failure(.refreshTokenRequestFailed))
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200,
                          let cookieString =  httpResponse.allHeaderFields["Set-Cookie"] as? String else {
                        completion(.failure(.refreshTokenRequestFailed))
                        return
                    }
                    
                    let cookieArray = cookieString.components(separatedBy: "; ")
                    guard cookieArray[0].hasPrefix("session=") else {
                        completion(.failure(.refreshTokenRequestFailed))
                        return
                    }
                    
                    guard cookieArray[1].hasPrefix("expires=") else {
                        completion(.failure(.refreshTokenRequestFailed))
                        return
                    }
                    
                    let cookie = cookieArray[0].replacingOccurrences(of: "session=", with: "")
                    let expiryDateString = cookieArray[1].replacingOccurrences(of: "expires=", with: "")
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
                    guard let expiryDate = dateFormatter.date(from: expiryDateString) else {
                        completion(.failure(.refreshTokenRequestFailed))
                        return
                    }
                    
                    UserDefaultsHelper.shared.setCookie(cookie)
                    UserDefaultsHelper.shared.setExpiryDate(expiryDate)
                    NSLog("cookie: \(cookie)\nexpiryDate: \(expiryDate)")
                    completion(.success(()))
                }
                task.resume()
            }
        })
    }
    
    
    // MARK: - Profile
    func getUserInfo(cookie: String, completion: @escaping (Result<User, NetworkServiceError>) -> Void) {
        
        let userInfoURL = baseURL.appendingPathComponent("user/info")
        
        var request = URLRequest(url: userInfoURL)
        request.httpMethod = "GET"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.userInfoRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.userInfoRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let user = try? jsonDecoder.decode(User.self, from: data) {
                completion(.success(user))
            } else {
                completion(.failure(.userInfoRequestFailed))
                return
            }
        }
        task.resume()
    }
    
    func getUserStatistics(cookie: String, completion: @escaping (Result<Statistics, NetworkServiceError>) -> Void) {
        
        let userStatisticsURL = baseURL.appendingPathComponent("user/statistics")
        
        var request = URLRequest(url: userStatisticsURL)
        request.httpMethod = "GET"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.userStatisticsRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.userStatisticsRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let statistics = try? jsonDecoder.decode(Statistics.self, from: data) {
                completion(.success(statistics))
            } else {
                completion(.failure(.userStatisticsRequestFailed))
            }
        }
        task.resume()
    }
    
    func changeUsername(cookie: String, newUsername: String, completion: @escaping (Result<Void, NetworkServiceError>) -> Void) {
        
        let userEditURL = baseURL.appendingPathComponent("user/edit/\(newUsername)")
        
        var request = URLRequest(url: userEditURL)
        request.httpMethod = "PATCH"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.usernameChangeRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.usernameChangeRequestFailed))
                return
            }
            
            completion(.success(()))
        }
        task.resume()
    }
    
    func getUserAchievements(cookie: String, completion: @escaping (Result<[Achievement], NetworkServiceError>) -> Void) {
        
        let userAchievementsURL = baseURL.appendingPathComponent("user/achievements")
        
        var request = URLRequest(url: userAchievementsURL)
        request.httpMethod = "GET"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.userAchievementsRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.userAchievementsRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let achievements = try? jsonDecoder.decode([Achievement].self, from: data) {
                completion(.success(achievements))
            } else {
                completion(.failure(.userAchievementsRequestFailed))
            }
        }
        task.resume()
    }
    
    
    // MARK: - Skin Store
    func getSkinsList(cookie: String, completion: @escaping (Result<[Skin], NetworkServiceError>) -> Void) {
        
        let skinsListURL = baseURL.appendingPathComponent("store/skins/list")
        
        var request = URLRequest(url: skinsListURL)
        request.httpMethod = "GET"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.skinsListRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.skinsListRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let skins = try? jsonDecoder.decode(Array<Skin>.self, from: data) {
                completion(.success(skins))
            } else {
                completion(.failure(.skinsListRequestFailed))
            }
        }
        task.resume()
    }
    
    func selectSkin(cookie: String, id: Int, completion: @escaping (Result<Bool, NetworkServiceError>) -> Void) {
        
        let selectSkinURL = baseURL.appendingPathComponent("store/skins/select/\(id)")
        
        var request = URLRequest(url: selectSkinURL)
        request.httpMethod = "PATCH"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.skinSelectionRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.skinSelectionRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let result = try? jsonDecoder.decode([String: Bool].self, from: data),
               let isTrue = result["result"] {
                if isTrue {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } else {
                completion(.failure(.skinSelectionRequestFailed))
            }
        }
        task.resume()
    }
    
    func buySkin(cookie: String, id: Int, completion: @escaping (Result<Bool, NetworkServiceError>) -> Void) {
        
        let skinsListURL = baseURL.appendingPathComponent("store/skins/buy/\(id)")
        
        var request = URLRequest(url: skinsListURL)
        request.httpMethod = "POST"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.skinBuyingRequestFailed))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 405 {
                completion(.success(false))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.skinBuyingRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let result = try? jsonDecoder.decode([String: Bool].self, from: data),
               let isTrue = result["result"] {
                if isTrue {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            } else {
                completion(.failure(.skinBuyingRequestFailed))
            }
        }
        task.resume()
    }
    
    func getUserBalance(cookie: String, completion: @escaping (Result<Int, NetworkServiceError>) -> Void) {
        
        let userBalanceURL = baseURL.appendingPathComponent("user/balance")
        
        var request = URLRequest(url: userBalanceURL)
        request.httpMethod = "GET"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.userBalanceRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.userBalanceRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let result = try? jsonDecoder.decode([String: Int].self, from: data),
               let balance = result["balance"] {
                completion(.success(balance))
            } else {
                completion(.failure(.userBalanceRequestFailed))
            }
        }
        task.resume()
    }
    
    // MARK: - Game
    func getWaitingRoomInfo(cookie: String, completion: @escaping (Result<WaitingRoomStartInfo, NetworkServiceError>) -> Void) {
        
        let waitingRoomInfoURL = baseURL.appendingPathComponent("game/waiting_room/get_info")
        
        var request = URLRequest(url: waitingRoomInfoURL)
        request.httpMethod = "POST"
        request.setValue("set-session=\(cookie)", forHTTPHeaderField: "cookie")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.waitingRoomInfoRequestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.waitingRoomInfoRequestFailed))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let waitingRoomInfo = try? jsonDecoder.decode(WaitingRoomStartInfo.self, from: data) {
                completion(.success(waitingRoomInfo))
            } else {
                completion(.failure(.waitingRoomInfoRequestFailed))
            }
        }
        task.resume()
    }
    
    
    // MARK: - Skin Image
    func getSkinImage(from url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 401 {
                completion(.failure(.authError))
                UserDefaultsHelper.shared.removeCookie()
                UserDefaultsHelper.shared.removeExpiryDate()
                return
            }
            
            if let _ = error {
                completion(.failure(.imageDataMissing))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.imageDataMissing))
                return
            }
            
            guard let imageData = data else {
                completion(.failure(.imageDataMissing))
                return
            }
            completion(.success(imageData))
        }
        task.resume()
    }
    
}

