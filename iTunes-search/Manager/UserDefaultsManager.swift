//
//  UserDefaultsManager.swift
//  iTunes-search
//
//  Created by junehee on 8/10/24.
//

import Foundation

struct UserDefaultsManager {
    
    enum UserDefaultsKey: String {
        case recentSearch
    }
    
    static func set<T>(to: T, forKey: UserDefaultsKey) {
            UserDefaults.standard.setValue(to, forKey: forKey.rawValue)
            print("UserDefaultsManager Save '\(forKey)'")
        }
        
    static func get(forKey: UserDefaultsKey) -> Any? {
        return UserDefaults.standard.object(forKey: forKey.rawValue)
    }

}
