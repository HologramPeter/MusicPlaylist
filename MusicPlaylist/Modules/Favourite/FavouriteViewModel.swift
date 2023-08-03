//
//  FavouriteViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

class FavouriteViewModel{
    var data: [MusicInfo]
    
    init() {
        self.data = UserConfigs.favouriteList!;
    }
}
