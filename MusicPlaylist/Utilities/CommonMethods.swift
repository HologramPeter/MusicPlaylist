//
//  CommonMethods.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

struct CommonMethods{
    static func isFavourite(_ info: MusicInfo) -> Bool{
        if info.primaryKey == nil {return false}
        return UserConfigs.favouriteList?.firstIndex(where: {$0.primaryKey == info.primaryKey}) != nil
    }
    
    static func setFavourite(_ info: MusicInfo, on: Bool = true){
        if info.primaryKey == nil {return}
        if on{
            if !CommonMethods.isFavourite(info){
                var list = UserConfigs.favouriteList
                list?.append(info)
                UserConfigs.favouriteList = list
            }
        }else{
            var list = UserConfigs.favouriteList
            list?.removeAll(where: {$0.primaryKey == info.primaryKey})
            UserConfigs.favouriteList = list
        }
    }
}
