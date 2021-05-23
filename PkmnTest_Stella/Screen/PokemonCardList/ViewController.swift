//
//  ViewController.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ViewController: UIViewController {

    var collectionView: UICollectionView?
    var searchController = UISearchController(searchResultsController:  nil)
    
    var presenter: PokemonCardViewToPresenterProtocol?

    var cards: [PokemonCardModel] = []
    var indexOfPageToRequest = 1
    var haveNextPage = true
    var searchStr = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
         configNavigation()
         configCollectionView()
         
         presenter = PokemonCardRouter.initPresenter(vc: self)
         presenter?.startFetchingData(page: indexOfPageToRequest, query: "")
    }
    
    func configNavigation() {
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.searchController.searchBar.searchTextField.backgroundColor = Color.background
        self.searchController.searchBar.searchTextField.textColor = Color.text
        self.searchController.searchBar.searchTextField.tintColor = Color.text

        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Color.navigation
        self.navigationController?.navigationBar.tintColor = Color.text
    }
    
    func configCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let heightTopBar = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height ?? 0)
        
        var height = 0
        if navigationController?.navigationBar.frame.size.height == 44 {
            height = 12
        }
        
        let frame = CGRect(x: 0, y: CGFloat(height), width:  self.view.frame.width, height: self.view.frame.height - heightTopBar)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(UINib(nibName: "PokemonCardCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView?.register(UINib(nibName: "IndicatorCell", bundle: nil), forCellWithReuseIdentifier: "indicatorCell")
        
        collectionView?.backgroundColor = Color.background
        view.addSubview(collectionView ?? UICollectionView())
    }
}

extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        haveNextPage = true
        cards = []
        indexOfPageToRequest = 1
        searchStr = searchText
        presenter?.startFetchingData(page: indexOfPageToRequest, query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        haveNextPage = true
        cards = []
        indexOfPageToRequest = 1
        searchStr = ""
        presenter?.startFetchingData(page: indexOfPageToRequest, query: "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.searchTextField.text == "" {
            haveNextPage = true
            cards = []
            indexOfPageToRequest = 1
            presenter?.startFetchingData(page: indexOfPageToRequest, query: "")
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchStr != "" {
            haveNextPage = true
            searchBar.searchTextField.text = searchStr
        }
    }
    
    @IBAction func tapRetry(_ sender: Any) {
        DispatchQueue.main.async {
            self.collectionView?.isHidden = false
        }
        presenter?.startFetchingData(page: indexOfPageToRequest, query: "")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cards.count > 0 {
            if haveNextPage {
                return cards.count+1
            } else {
                return cards.count
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < cards.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PokemonCardCell

            cell.backgroundColor = Color.background
            cell.imageView.sd_setImage(with: URL(string: cards[indexPath.row].images?.small ?? ""), placeholderImage: Image.placeholderImage)

            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicatorCell", for: indexPath) as! IndicatorCell
            
            cell.backgroundColor = Color.background
            cell.tintColor = .white
            cell.indicator.startAnimating()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row < cards.count {
            let yourWidth = (collectionView.bounds.width-24)/2.0
            let yourHeight = yourWidth*3/2-10

            return CGSize(width: yourWidth, height: yourHeight)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 46)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        } else {
            return UIEdgeInsets.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == cards.count {
            indexOfPageToRequest += 1
            presenter?.startFetchingData(page: indexOfPageToRequest, query: searchController.searchBar.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PokemonCardDetail()
        vc.card = cards[indexPath.row]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: PokemonCardPresenterToViewProtocol {
    func showData(array: Array<PokemonCardModel>) {
        self.collectionView?.isHidden = false

        cards += array
        if array.count<20 {
            haveNextPage = false
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.collectionView?.isHidden = true
        }
    }
}
