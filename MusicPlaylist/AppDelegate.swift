//
//  AppDelegate.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LanguageLocalizer.DoTheSwizzling()
        return true
    }

}

