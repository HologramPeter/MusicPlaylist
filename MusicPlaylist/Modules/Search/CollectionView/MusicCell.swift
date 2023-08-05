//
//  MusicCell.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

protocol MusicCellDelegate{
    func onToggle(info: MusicInfo?, isFavourite: Bool) -> Void
}

class MusicCell: UICollectionViewCell{
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    static let defaultImage = UIImage(named: "music.note")
    static let onImage = UIImage(named: "star.fill")
    static let offImage = UIImage(named: "star")
    
    typealias `Self` = MusicCell
    static let identifier = "MusicCell"
    
    var delegate: MusicCellDelegate?
    var info: MusicInfo?
    var isFavourite: Bool = false

    func setup(delegate: MusicCellDelegate, info: MusicInfo, image: UIImage?, isFavourite: Bool) {
        self.delegate = delegate
        self.info = info
        self.isFavourite = isFavourite
        
        titleLbl.text = info.name
        descLbl.text = info.artistName
        leftImageView.image = image ?? Self.defaultImage
        btnFavourite.setTitleText("", for: .normal)
        btnFavourite.setImage(self.isFavourite ? Self.onImage: Self.offImage, for: .normal)
    }
    
    @IBAction func toggleFavourite(sender: Any){
        isFavourite = !isFavourite
        btnFavourite.setImage(isFavourite ? Self.onImage: Self.offImage, for: .normal)
        delegate?.onToggle(info: info, isFavourite: isFavourite)
    }
}
