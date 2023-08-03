//
//  UserConfigs.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults = .standard
    
    var wrappedValue: T? {
        get {
            let v = userDefaults.object(forKey: key)
            if v == nil{
                return defaultValue
            }else{
                return v as? T ?? defaultValue
            }
        }
        set {
            if newValue == nil {
               UserDefaults.standard.removeObject(forKey: key)
            }else{
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

@propertyWrapper
struct UserDefaultsDataWrapper<T: Codable>{
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaults = .standard
    
    var wrappedValue: T? {
        get {
            let v = userDefaults.object(forKey: key) as? Data
            if v == nil{
                return defaultValue
            }else{
                return (try? JSONDecoder().decode(T.self, from: v!)) ?? defaultValue
            }
        }
        set {
            let value = try? JSONEncoder().encode(newValue)
            if value == nil {
               UserDefaults.standard.removeObject(forKey: key)
            }else{
                userDefaults.set(value, forKey: key)
            }
        }
    }
}

struct UserConfigs {
    @UserDefaultsWrapper(key: "FavouriteMusicList", defaultValue: [])
    static var favouriteList: [MusicInfo]?
}
