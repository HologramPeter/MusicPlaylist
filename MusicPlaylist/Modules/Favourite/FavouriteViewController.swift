//
//  FavouriteViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 3/8/2023.
//

import Foundation
import UIKit

class FavouriteViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FavouriteViewModel()
    
    let cellHeight:CGFloat = 50
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI(){
        setupCollectionView()
    }
    
    func removeMusic(music: MusicInfo){
        viewModel.removeFromList(music: music)
        collectionView.reloadData()
    }
}


extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func setupCollectionView(){
        collectionView.backgroundColor = Constants.appBackgroundColor
        collectionView.register(UINib(nibName: "MusicCell", bundle: nil), forCellWithReuseIdentifier: MusicCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell {
            cell.setup(viewModel.data[indexPath.section][indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
