//
//  Networking.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Alamofire

class Networking{
    func request<R>(_ resource: R, completion: @escaping (Result<R.Response, Error>) -> Void) where R : RequestProtocol {
        var httpHeaders: Alamofire.HTTPHeaders?
        if let headers = resource.headers{
            httpHeaders = headers
        }
        let path = "https://itunes.apple.com/search?\(resource.path)"
        let url = URL(string: path)!
        AF.request(url, method: resource.method, parameters: resource.parameters, encoding: JSONEncoding.default, headers: httpHeaders)
            .responseDecodable(of: R.Response.self) { response in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let afError):
                    completion(.failure(afError))
                }
            }
    }
}
