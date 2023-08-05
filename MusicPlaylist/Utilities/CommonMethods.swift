//
//  CommonMethods.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

struct CommonMethods{
    static func isFavourite(_ info: MusicInfo) -> Bool{
        return UserConfigs.favouriteList?.firstIndex(where: {$0.primaryKey == info.primaryKey}) != nil
    }
    
    static func setFavourite(_ info: MusicInfo, on: Bool = true){
        if on{
            if !CommonMethods.isFavourite(info){
                UserConfigs.favouriteList?.append(info)
            }
        }else{
            UserConfigs.favouriteList?.removeAll(where: {$0.primaryKey == info.primaryKey})
        }
    }
}
