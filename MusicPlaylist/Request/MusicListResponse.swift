//
//  MusicInfo.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import Foundation

struct MusicListResponse: Decodable{
    let resultCount: Int
    let results: [MusicInfo]
}

struct MusicInfo: Decodable{
    let wrapperType: MusicWrapperType
    
    let trackExplicitness: MusicExplicitness?
    let collectionExplicitness: MusicExplicitness?
    let artistExplicitness: MusicExplicitness?
    
    let kind: MusicKind?
    let trackName: String?
    let artistName: String?
    let collectionName: String?
    
    let trackCensoredName: String?
    let collectionCensoredName: String?
    let artistCensoredName: String?
    
    let artworkUrl100: String?
    let artworkUrl60: String?
    
    let trackViewUrl: String?
    let collectionViewUrl: String?
    let artistViewUrl: String?
    
    let previewURL: String?
    let trackTimeMillis: Int?
}

extension MusicInfo{
    var name: String?{
        switch wrapperType{
        case .track:
            return trackName
        case .collection:
            return collectionName
        case .artist:
            return artistName
        case .unsupported:
            return nil
        }
    }
    
    var explicitness: MusicExplicitness?{
        switch wrapperType{
        case .track:
            return trackExplicitness
        case .collection:
            return collectionExplicitness
        case .artist:
            return artistExplicitness
        case .unsupported:
            return nil
        }
    }
    
    var viewURL: String?{
        switch wrapperType{
        case .track:
            return trackViewUrl
        case .collection:
            return collectionViewUrl
        case .artist:
            return artistViewUrl
        case .unsupported:
            return nil
        }
    }
    
    var censoredName: String?{
        switch wrapperType{
        case .track:
            return trackCensoredName
        case .collection:
            return collectionCensoredName
        case .artist:
            return artistCensoredName
        case .unsupported:
            return nil
        }
    }
    
    var primaryKey: String?{
        return viewURL
    }
}

enum MusicWrapperType: String, Decodable{
    case track
    case collection
    case artist
    case unsupported
    
    init?(rawValue: String) {
        switch rawValue{
        case "track":
            self = .track
        case "collection":
            self = .collection
        case "artist":
            self = .artist
        default:
            self = .unsupported
        }
    }
}

enum MusicExplicitness: String, Decodable{
    case explicit
    case cleaned
    case notExplicit
}

enum MusicKind: String, Decodable{
    case book
    case album
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdf = "pdf"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song = "song"
    case tvEpisode = "tv-episode"
    case artist = "artist"
    case podcast = "podcast"
}
