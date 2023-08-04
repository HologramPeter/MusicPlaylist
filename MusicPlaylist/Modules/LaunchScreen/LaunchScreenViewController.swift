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
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: Constants.appHighlightColor
            ]
            appearance.backgroundColor = Constants.appForegroundColor
            UINavigationBar.appearance().tintColor = Constants.appHighlightColor
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabBar = TabBarBuilder.build()
        self.present(tabBar, animated: false)
    }

}
