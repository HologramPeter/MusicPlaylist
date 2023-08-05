//
//  SearchViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias `Self` = SearchViewController
    static let filterOnImage = UIImage(named: "filter.fill")
    static let filterOffImage = UIImage(named: "filter")
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func setupUI(){
        setupCollectionView()
        setupSearchBar()
        btnFilter.setTitle("", for: .normal)
        btnFilter.setImage(Self.filterOffImage, for: .normal)
    }
    
    func bind(){
        viewModel.onError = showErrorMessage
        viewModel.loading.bind{ loading in
            if !loading{
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func toggleFilter(sender: Any){
        viewModel.filterMode = !viewModel.filterMode
        btnFilter.setImage(viewModel.filterMode ? Self.filterOnImage : Self.filterOffImage, for: .normal)
        searchBar.endEditing(true)
        if viewModel.filterMode{
            searchBar.placeholder = "search_hint_filter".localized
            searchBar.text = viewModel.filterStr
        }else{
            searchBar.placeholder = "search_hint_search".localized
            searchBar.text = viewModel.request.term
        }
    }
}

extension SearchViewController: UISearchBarDelegate{
    func setupSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar)
    }
    
    func search(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        if viewModel.filterMode{
            viewModel.filter(searchBar.text)
            collectionView.reloadData()
        }else{
            checkInternetConnection {
                viewModel.search(searchBar.text)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MusicCellDelegate{
    func onToggle(info: MusicInfo?, isFavourite: Bool) {
        if let info = info{
            CommonMethods.setFavourite(info, on: isFavourite)
        }
    }
    
    func setupCollectionView(){
        collectionView.backgroundColor = Constants.appBackgroundColor
        collectionView.register(UINib(nibName: "MusicCell", bundle: nil), forCellWithReuseIdentifier: MusicCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.displayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell {
            let info = viewModel.displayData[indexPath.row]
            let image = viewModel.images[info.artworkUrl60 ?? ""]
            let isFavourite = CommonMethods.isFavourite(info)
            cell.setup(delegate: self, info: info, image: image, isFavourite: isFavourite)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.displayData.count - 1 && !viewModel.loading.value && Connectivity.isConnectedToInternet{
            viewModel.loadMoreData()
        }
    }

}
