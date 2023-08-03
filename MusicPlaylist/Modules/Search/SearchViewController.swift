//
//  SearchViewController.swift
//  MusicPlaylist
//
//  Created by Peter Ho on 2/8/2023.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    func setupUI(){
        
    }
    
    func bind(){
        viewModel.onError = showErrorMessage
    }

    @IBAction func searchForMusic(_ sender: UISearchBar?){
        if let term = sender?.text{
            checkInternetConnection {
                viewModel.search(term: term)
            }
        }
    }

}

extension SearchViewController: UICollectionViewDelegate{
    private func collectionView(_ collectionView: UICollectionViewDelegate, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.data.count - 1 && !viewModel.loading.value && Connectivity.isConnectedToInternet{
            viewModel.loadMoreData()
        }
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionViewCell()
    }
    
    private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell {
            cell.setup(viewModel.data[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

