//
//  UIViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromStoryboard(inBundle bundle: Bundle = .main, storyboard: String) -> Self {
        func helper<T>() -> T {
            let sb = UIStoryboard(name: storyboard, bundle: bundle)
            return sb.instantiateViewController(withIdentifier: String(describing: self)) as! T
        }
        return helper()
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func showErrorMessage(_ message: String){
        AlertHelper.present(in: self, title: "alert_error".localized, message: message)
    }
    
    func checkInternetConnection(_ action: () -> Void){
        if Connectivity.isConnectedToInternet {
            action()
        } else {
            showErrorMessage("alert_desc_offline".localized)
        }
    }
}
