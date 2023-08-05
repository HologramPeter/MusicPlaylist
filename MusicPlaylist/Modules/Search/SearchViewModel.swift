//
//  SearchViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Foundation
import Alamofire

class SearchViewModel{
    var loading = Observable<Bool>(false)
    
    var displayData: [MusicInfo] = []
    var data: [MusicInfo] = []
    var images: [String: UIImage] = [:]
    
    var filterMode = false{
        didSet{
            filterDisplayData()
        }
    }
    var request: MusicListRequest = MusicListRequest()
    var filterStr = ""
    var onError: ((String) -> Void)?
    
    private var downloadTask = 0
    
    func search(_ term: String?){
        request.term = term ?? ""
        if request.term == ""  {return}
        request.pageInd = 0
        loading.value = true
        request.request(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.data = response.results
                self?.filterDisplayData()
                self?.downloadTask = response.results.count
                for info in response.results{
                    self?.downloadImage(info: info)
                }
            case .failure(let errorMsg):
                self?.onError?(errorMsg)
            }
            self?.loading.value = false
        })
    }
    
    func loadMoreData(){
        request.pageInd += 1
        loading.value = true
        request.request(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.data.append(contentsOf: response.results)
                self?.filterDisplayData()
                self?.downloadTask = response.results.count
                for info in response.results{
                    self?.downloadImage(info: info)
                }
            case .failure(let errorMsg):
                self?.onError?(errorMsg)
                self?.loading.value = false
            }
        })
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
    
    func filter(_ term: String?){
        filterStr = term ?? ""
        filterDisplayData()
    }
    
    func filterDisplayData(){
        if filterMode && filterStr != ""{
            displayData = data.filter({$0.artistName?.contains(filterStr) ?? false || $0.country?.contains(filterStr) ?? false})
            print("filtered count: \(data.count - displayData.count)")
        }else{
            displayData = data
        }
    }
}
