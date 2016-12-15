//
//  GKBRecommendGameView.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/12.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
private let gRemcomendGameItem = "gRemcomendGameItem"

class GKBRecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var gmaeAnchorRooms : [GKBGroupModel]? {
        didSet {
         
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GKBRecomendGameViewCell", bundle: nil), forCellWithReuseIdentifier: gRemcomendGameItem)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    class func laodRecommendGameView()-> GKBRecommendGameView {
        
        return Bundle.main.loadNibNamed("GKBRecommendGameView", owner: nil, options: nil)?.first as! GKBRecommendGameView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }

}
extension GKBRecommendGameView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gmaeAnchorRooms?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: gRemcomendGameItem, for: indexPath) as! GKBRecomendGameViewCell
        guard let anchorRoom = gmaeAnchorRooms?[indexPath.item] else {return item }
        item.gameAnchorRoom = anchorRoom
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
