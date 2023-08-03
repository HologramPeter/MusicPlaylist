//
//  MusicCell.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

class MusicCell: UICollectionViewCell{
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var remarksLbl: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    typealias `Self` = MusicCell
    static let identifier = "MusicCell"
    
    var isFavourite: Bool = false

    func setup(_ info: MusicInfo) {
        titleLbl.text = info.name
        isFavourite = CommonMethods.isFavourite(info)
        //setup btns and image
        // downloadImage(from: )
        //URL(string: info.viewURL?? "")
    }
    
    func downloadImage(from url: URL) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            // always update the UI from the main thread
//            DispatchQueue.main.async() { [weak self] in
//                self?.imageView.image = UIImage(data: data)
//            }
//        }
    }
    
    @objc
    func toggleFavourite(){
        
    }
}
