//
//  UserDefaultsHelper.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 15.03.2023.
//

import Foundation

protocol UserDefaultsHelperProtocol {
    
    static var shared: UserDefaultsHelper { get set }
    
    func getCookie() -> String?
    func setCookie(_ cookie: String)
    func removeCookie()
    
}

class UserDefaultsHelper: UserDefaultsHelperProtocol {
    
    static var shared: UserDefaultsHelper = UserDefaultsHelper()
    
    func getCookie() -> String? {
        return UserDefaults.standard.string(forKey: "cookie")
    }
    
    func setCookie(_ cookie: String) {
        UserDefaults.standard.set(cookie, forKey: "cookie")
    }
    
    func removeCookie() {
        UserDefaults.standard.removeObject(forKey: "cookie")
    }
    
    func setExpiryDate(_ expiryDate: Date) {
        return UserDefaults.standard.set(expiryDate, forKey: "expiryDate")
    }
    
    func getExpiryDate() -> Date? {
        return UserDefaults.standard.object(forKey: "expiryDate") as? Date
    }
    
    func removeExpiryDate() {
        UserDefaults.standard.removeObject(forKey: "expiryDate")
    }
}
