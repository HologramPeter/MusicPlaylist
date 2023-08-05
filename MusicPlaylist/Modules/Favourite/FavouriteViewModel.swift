//
//  FavouriteViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit
import Alamofire

class FavouriteViewModel{
    var loading: Observable<Bool> = Observable(false)
    
    var data: [[MusicInfo]] = []
    var images: [String: UIImage] = [:]
    var downloadTask: Int = 0
    
    init() {
        reload()
    }
    
    func reload(){
        data = [UserConfigs.favouriteList!]
        print(data[0].count)
        if Connectivity.isConnectedToInternet{
            loading.value = true
            downloadTask = data[0].count
            for info in data[0]{
                downloadImage(info: info)
            }
        }
    }
    
    func downloadImage(info: MusicInfo) {
        if
            let urlStr = info.artworkUrl60,
            let url = URL(string: urlStr)
        {
            AF.request(url, method: .get, encoding: JSONEncoding.default).response(){ [weak self] response in
                if let data = response.data,
                   let image = UIImage(data: data){
                    self?.images[urlStr] = image
                }
                self?.completeDownload()
            }
        }else{
            completeDownload()
        }
    }
    
    func completeDownload(){
        downloadTask -= 1
        if downloadTask == 0{
            loading.value = false
        }
    }
    
    func removeFromList(music: MusicInfo){
        data[0].removeAll(where: {$0.primaryKey == music.primaryKey})
        UserConfigs.favouriteList = data[0]
    }
}
