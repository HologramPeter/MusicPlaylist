//
//  AlertHelper.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

struct AlertHelper {
    static func present(in parent: UIViewController,
                        title: String,
                        message: String,
                        style: UIAlertController.Style = .alert,
                        actionTitle: String? = "OK",
                        actionStyle: UIAlertAction.Style = .default,
                        handler: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: actionTitle, style: actionStyle) { _ in
            handler?()
        }
        alertController.addAction(okAction)
        
        parent.present(alertController, animated: true, completion: nil)
    }
    
    static func present(in parent: UIViewController,
                        title: String,
                        message: String,
                        style: UIAlertController.Style = .alert,
                        yesActionTitle: String? = "Yes",
                        noActionTitle: String? = "No",
                        yesActionStyle: UIAlertAction.Style = .default,
                        noActionStyle: UIAlertAction.Style = .default,
                        yesHandler: (() -> Void)? = nil,
                        noHandler: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let yesAction = UIAlertAction(title: yesActionTitle, style: yesActionStyle) { _ in
            yesHandler?()
        }
        let noAction = UIAlertAction(title: noActionTitle, style: noActionStyle) { _ in
            noHandler?()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        parent.present(alertController, animated: true, completion: nil)
    }
}
