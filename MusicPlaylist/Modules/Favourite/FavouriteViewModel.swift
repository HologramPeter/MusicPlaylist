//
//  FavouriteViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

class FavouriteViewModel{
    var data: [[MusicInfo]] = []
    
    init() {
//        self.data.append(UserConfigs.favouriteList!)
        
        let bundle = Bundle.main
        let path = bundle.path(forResource: "testData", ofType: "txt")
        
        let json = try? String(contentsOfFile: path!).data(using: .utf8)!
        
        let list = try? JSONDecoder().decode(MusicListResponse.self, from: json!)
        
        self.data.append(list!.results)
        print(data[0].count)
    }
    
    func removeFromList(music: MusicInfo){
        data[0].removeAll(where: {$0.primaryKey == music.primaryKey})
        UserConfigs.favouriteList = data[0]
    }
}
