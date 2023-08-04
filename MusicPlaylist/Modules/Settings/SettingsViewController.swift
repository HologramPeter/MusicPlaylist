//
//  SettingsViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var segmentLanguage: UISegmentedControl!
    @IBOutlet weak var btnReset: UIButton!
    
    var viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        segmentLanguage.removeAllSegments()
        
        var selectedIndex: Int = 0
        var i = 0
        for lang in LanguageSymbols.allCases {
            segmentLanguage.insertSegment(withTitle: lang.description, at: i, animated: false)
            if UserConfigs.languageSymbol == lang.rawValue{
                selectedIndex = i
            }
            
            i += 1
        }
        segmentLanguage.selectedSegmentIndex = selectedIndex
        
    }
    
    @IBAction func resetFavourite(){
        AlertHelper.present(in: self, title: "alert_title_reset".localized, message: "alert_desc_reset".localized, yesActionTitle: "alert_yes".localized, noActionTitle:  "alert_no".localized, yesHandler: {
            UserConfigs.favouriteList = nil
        })
    }
    
    @IBAction func updateLanguage(_ sender: Any) {
        let lang = LanguageSymbols.allCases[segmentLanguage.selectedSegmentIndex]
        UserConfigs.languageSymbol = lang.rawValue
        AlertHelper.present(in: self, title: "alert_title_lang".localized, message: "alert_desc_lang".localized)
    }
}
