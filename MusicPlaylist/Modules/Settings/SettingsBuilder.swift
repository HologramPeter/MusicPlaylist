//
//  SettingsBuilder.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

public class SettingsBuilder {
    class func build() -> UIViewController {
        let vc = SettingsViewController.loadFromStoryboard(storyboard: "Main")
        let vm = SettingsViewModel()
        vc.viewModel = vm
        return vc
    }
}

