//
//  SearchViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Foundation

class SearchViewModel{
    var loading = Observable<Bool>(false)
    var data: [[MusicInfo]] = []
    var request: MusicListRequest = MusicListRequest()
    
    var onError: ((String) -> Void)?
    
    func search(term: String){
        request.term = term
        request.pageInd = 0
        loading.value = true
        request.request(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.data = [response.results]
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
                self?.data.append(response.results)
            case .failure(let errorMsg):
                self?.onError?(errorMsg)
            }
            self?.loading.value = false
        })
    }
}
