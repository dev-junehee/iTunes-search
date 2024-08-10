//
//  UserDefaultsManager.swift
//  iTunes-search
//
//  Created by junehee on 8/10/24.
//

import Foundation

enum UserDefaultsKey: String {
    case recentSearch
}

struct UserDefaultsManager {
    
    @UserDefaultsWrapper (key: .recentSearch, defaultValue: [])
    static var recentSearch: [String]
   
    static func deleteAllRecentSearchList() {
        _recentSearch.delete()
    }
    
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}

// struct UserDefaultsManager {
//     
//     static let shared = UserDefaultsManager()
//     private init() { }
//     
//     enum UserDefaultsKey: String {
//         case recentSearch
//     }
//     
//     func set<T>(to: T, forKey: UserDefaultsKey) {
//             UserDefaults.standard.setValue(to, forKey: forKey.rawValue)
//             print("UserDefaultsManager Save '\(forKey)'")
//         }
//         
//     func get(forKey: UserDefaultsKey) -> Any? {
//         return UserDefaults.standard.object(forKey: forKey.rawValue)
//     }
// 
// }
