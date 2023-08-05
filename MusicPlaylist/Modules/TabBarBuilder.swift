//
//  TabBarBuilder.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 4/8/2023.
//

import Foundation
import UIKit

public class TabBarBuilder {
    class func build() -> UITabBarController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyBoard.instantiateViewController(withIdentifier: "UITabBarController")
           viewController.modalPresentationStyle = .fullScreen
           return viewController as! UITabBarController
    }
}
