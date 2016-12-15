//
//  BaseViewController.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

//import UIKit
//
//
//private let gLineSpacing : CGFloat = 10
//private let gItemW = (gScreenW - 3*gLineSpacing) / 2
//private let gNormalItemH = gItemW * 3/4
//private let gProttyItemH = gItemW * 4/3
//private let gHeaderViewH : CGFloat = 50
//private let gCarouselViewH : CGFloat = gScreenW * 3/8
//
//private let gNormalItemID = "gNormalItemID"
//private let gHeaderViewID = "gHeaderViewID"
//private let gProttyItemID = "gProttyItemID"
//
//
//class BaseAnchorViewController: UIViewController {
//    
//    var baseVM : BaseViewModel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//       
//    }
//
//    private lazy var collectionView : UICollectionView = {[weak self] in
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = gLineSpacing
//        layout.minimumInteritemSpacing = gLineSpacing
//        layout.itemSize = CGSize(width: gItemW, height: gNormalItemH)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: gLineSpacing, bottom: 10, right: gLineSpacing)
//        layout.headerReferenceSize = CGSize(width: gScreenW, height: gHeaderViewH)
//        
//        let collView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
//        collView.delegate = self
//        collView.dataSource = self
//        
//        collView.register(UINib(nibName: "GKBHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gNormalItemID)
//        //注册颜值Cell   GKBProttyCollectionViewCell
//        collView.register(UINib(nibName: "GKBProttyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gProttyItemID)
//        
//        return collView
//        }()
//    
//    
//    func setUpUi() {
//        view.addSubview(collectionView)
//    }
//    
//    
//
//}

//
//extension BaseAnchorViewController : UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return recomentVM.roomGroups.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        //        if  section == 0 { return 8 }
//        let anchorGroup = recomentVM.roomGroups[section]
//        return anchorGroup.anchorRooms.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let anchorGroup  = recomentVM.roomGroups[indexPath.section]
//        let anchorRoom = anchorGroup.anchorRooms[indexPath.item]
//        
//        var cellItem : GKBRecomendBaseCell!
//        
//        if indexPath.section == 1 {
//            cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: gProttyItemID, for: indexPath) as! GKBProttyCollectionViewCell
//            
//        }else{
//            cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: gNormalItemID, for: indexPath) as! GKBHomeCollectionViewCell
//        }
//        
//        cellItem.anchorRoom = anchorRoom
//        return cellItem
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        guard  let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: gHeaderViewID, for: indexPath) as? GKBCollectionHeaderReusableView else{ return UICollectionReusableView()}
//        let anchorGroup  = recomentVM.roomGroups[indexPath.section]
//        headView.anchorGroup = anchorGroup
//        
//        return headView
//    }
//}
