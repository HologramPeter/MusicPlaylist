//
//  RequestProtocol.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Alamofire

protocol RequestProtocol {
    associatedtype Response: Decodable
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}
