//
//  MusicListRequest.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Alamofire

class MusicListRequest{
    static let LIMIT = 20
    typealias `Self` = MusicListRequest
    var pageInd: Int
    var term: String
    
    init(pageInd: Int = 0, term: String = "") {
        self.pageInd = pageInd
        self.term = term
    }
    
    var offset: Int{
        return max(0, pageInd) * Self.LIMIT
    }
    
    var url: URL?{
        var queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(Self.LIMIT)")
//            URLQueryItem(name: "lang", value: "")
        ]
        
        if term != nil{
            queryItems.append(URLQueryItem(name: "term", value: term))
        }
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    func request(completion: @escaping (Result<MusicListResponse, String>) -> Void){
        guard let url = url else{
            completion(.failure("Unable to construct url"))
            return
        }
        print(url.absoluteString)
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseDecodable(of: MusicListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let afError):
                    completion(.failure(afError.localizedDescription))
                }
            }
    }
}
