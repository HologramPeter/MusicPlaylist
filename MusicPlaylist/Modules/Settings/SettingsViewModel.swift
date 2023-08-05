//
//  SettingsViewModel.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation

class SettingsViewModel{
    func resetFavourite(){
        UserConfigs.favouriteList = nil
    }
    
    func setLanguage(_ lang: LanguageSymbols){
        UserConfigs.languageSymbol = lang.rawValue
    }
}
