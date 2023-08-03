//
//  SearchBuilder.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

public class SearchBuilder {
    class func build() -> UIViewController {
        let vc = SearchViewController.loadFromStoryboard(storyboard: "Main")
        let vm = SearchViewModel()
        vc.viewModel = vm
        return vc
    }
}
