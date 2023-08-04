//
//  LanguageChanger.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

enum LanguageSymbols: String, CaseIterable{
    case en = "en"
    case tc = "zh"
    case sc = "zh_CN"
    
    var description:String{
        switch self {
        case .en:
            return "English"
        case .tc:
            return "繁體中文"
        case .sc:
            return "简体中文"
        }
    }
    
    static var Default:LanguageSymbols{
        return .en
    }
}

class LanguageLocalizer: NSObject {
    class func DoTheSwizzling() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
    }
    
}

extension Bundle {
    @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LanguageSymbols.init(rawValue: UserConfigs.languageSymbol ?? "") ?? .en
        var bundle = Bundle();
        
        if let _path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "en", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }
}

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
