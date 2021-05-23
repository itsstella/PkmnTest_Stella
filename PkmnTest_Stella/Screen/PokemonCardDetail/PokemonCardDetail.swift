//
//  PokemonCardDetail.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import ImageViewer

class PokemonCardDetail: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var flavorLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var card: PokemonCardModel?
    var cards: [PokemonCardModel] = []
    var presenter: PokemonCardDetailViewToPresenterProtocol?
    
    var indexOfPageToRequest = 1
    var haveNextPage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationBar()
        setData()
        configTapGesture()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView?.register(UINib(nibName: "PokemonCardCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView?.register(UINib(nibName: "IndicatorCell", bundle: nil), forCellWithReuseIdentifier: "indicatorCell")
        
        presenter = PokemonCardDetailRouter.initPresenter(vc: self)
        presenter?.startFetchingData(page: indexOfPageToRequest, subtype: (card?.subtypes ?? []), types: (card?.types ?? []))
    }
    
    func configNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Color.navigation
        self.navigationController?.navigationBar.tintColor = Color.text
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.text]
        
        self.title = card?.name
    }
    
    func configTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))

        self.image.addGestureRecognizer(tapGestureRecognizer)
        self.image.isUserInteractionEnabled = true
    }
    
    func setData() {
        image.sd_setImage(with: URL(string: card?.images?.large ?? ""), placeholderImage: Image.placeholderImage)
        nameLabel.text = card?.name
        
        var hp = ""
        for i in 0..<(card?.types?.count ?? 0) {
            hp += card?.types?[i] ?? ""
            if i<(card?.types?.count ?? 0)-1 {
                hp += ", "
            }
        }
        hp += " (HP "+(card?.hp ?? "")+")"
        hpLabel.text = hp
        
        var type = (card?.supertype ?? "") + " - "
        for i in 0..<(card?.subtypes?.count ?? 0) {
            type += card?.subtypes?[i] ?? ""
            if i<(card?.subtypes?.count ?? 0)-1 {
                type += ", "
            }
        }
        typeLabel.text = type
        
        flavorLabel.text = card?.flavorText ?? "-"
    }
    
    @objc func tapImage(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            ImageViewer.show(image, presentingVC: self)
        }
    }
}

extension PokemonCardDetail: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

            cell.imageView.sd_setImage(with: URL(string:cards[indexPath.row].images?.small ?? ""), placeholderImage: Image.placeholderImage)

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicatorCell", for: indexPath) as! IndicatorCell
            
            cell.indicator.startAnimating()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        if indexPath.row < cards.count {
            let yourHeight = collectionView.bounds.height
            let yourWidth = yourHeight*2/3
            
            return CGSize(width: yourWidth, height: yourHeight)
        } else {
            return CGSize(width: 50, height: collectionView.bounds.height)
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
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == cards.count {
            indexOfPageToRequest += 1
            presenter?.startFetchingData(page: indexOfPageToRequest, subtype: (card?.subtypes ?? []), types: (card?.types ?? []))
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

extension PokemonCardDetail: PokemonCardDetailPresenterToViewProtocol {
    func showData(array: Array<PokemonCardModel>) {
        cards += array
        if array.count<10 {
            haveNextPage = false
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func showError() {
        
    }
}
