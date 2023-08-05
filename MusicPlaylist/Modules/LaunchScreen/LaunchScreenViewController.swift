//
//  LaunchScreenViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabBar = TabBarBuilder.build()
        if UserConfigs.favouriteList?.count == 0{
            tabBar.selectedIndex = 1
        }else{
            tabBar.selectedIndex = 0
        }
        self.present(tabBar, animated: false)
    }

}
