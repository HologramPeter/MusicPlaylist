//
//  UIElements.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 4/8/2023.
//

import Foundation
import UIKit

extension UIButton {
    func setTitleText(_ text:String, for state:UIControl.State){
        setTitle(text, for: state)
        guard let attrTitle = attributedTitle(for: .normal) else {return}
        let str = NSMutableAttributedString(attributedString: attrTitle)
        str.mutableString.setString(text)
        setAttributedTitle(str, for: .normal)
    }
}
