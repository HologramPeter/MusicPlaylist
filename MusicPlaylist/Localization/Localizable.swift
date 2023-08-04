//
//  Localizable.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

public protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

public protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            guard let key = key else {return}
            setTitleText(key.localized, for: .normal)
        }
    }
}

extension UINavigationItem: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized.uppercased()
        }
    }
}

extension UIBarItem: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}

extension UITextField{
    @IBInspectable public var xibPlaceholderLocKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

extension UIViewController{
    @IBInspectable public var xibLocKeys: String? {
        get { return nil }
        set(key) {
            title = (key?.localized.uppercased() ?? "" )
            tabBarItem.title = ""
        }
    }
}

extension UISearchBar: XIBLocalizable {
    @IBInspectable public var xibLocKey: String? {
        get { return nil }
        set(key) {
            guard let key = key else {return}
            placeholder = key.localized
        }
    }
}
