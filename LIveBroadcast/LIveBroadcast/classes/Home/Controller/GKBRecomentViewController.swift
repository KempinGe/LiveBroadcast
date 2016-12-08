//
//  GKBRecomentViewController.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/6.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

private let gLineSpacing : CGFloat = 10
private let gItemW = (gScreenW - 3*gLineSpacing) / 2
private let gNormalItemH = gItemW * 3/4
private let gProttyItemH = gItemW * 4/3
private let gHeaderViewH : CGFloat = 50

private let gNormalItemID = "gNormalItemID"
private let gHeaderViewID = "gHeaderViewID"
private let gProttyItemID = "gProttyItemID"


class GKBRecomentViewController: UIViewController {
    var recomentVM = GKBRecomentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUi()
        recomentVM.requestData(finishCallBack: {[weak self] in
            self?.collectionView.reloadData()
        })
    }

    //MARK:-懒加载创建collectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = gLineSpacing
        layout.minimumInteritemSpacing = gLineSpacing
        layout.itemSize = CGSize(width: gItemW, height: gNormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: gLineSpacing, bottom: 10, right: gLineSpacing)
        layout.headerReferenceSize = CGSize(width: gScreenW, height: gHeaderViewH)
       
        let collView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        
        return collView
    }()
    
    //MARK:- setUpUI
    private func setUpUi() {
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //注册Cell
        collectionView.register(UINib(nibName: "GKBHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gNormalItemID)
        
        //注册颜值Cell   GKBProttyCollectionViewCell
        collectionView.register(UINib(nibName: "GKBProttyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gProttyItemID)
        
        
        
        //注册collectionView分区头的试图
        collectionView.register( UINib(nibName: "GKBCollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gHeaderViewID)
        
        //设置collectionView随着父试图的缩放而缩放
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}

//MARK:- collectionView的数据源方法   UICollectionViewDelegateFlowLayout这个协议继承自UICollectionViewDelegate协议
extension GKBRecomentViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomentVM.roomGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if  section == 0 { return 8 }
        let anchorGroup = recomentVM.roomGroups[section]
        return anchorGroup.anchorRooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anchorGroup  = recomentVM.roomGroups[indexPath.section]
        let anchorRoom = anchorGroup.anchorRooms[indexPath.item]
        if indexPath.section == 1 {
            let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: gProttyItemID, for: indexPath) as! GKBProttyCollectionViewCell
            
            cellItem.anchorRoom = anchorRoom
        
            return cellItem
    
        }else{
            let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: gNormalItemID, for: indexPath) as! GKBHomeCollectionViewCell
            
            cellItem.anchorRoom = anchorRoom
            return cellItem
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard  let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: gHeaderViewID, for: indexPath) as? GKBCollectionHeaderReusableView else{ return UICollectionReusableView()}
        let anchorGroup  = recomentVM.roomGroups[indexPath.section]
        headView.anchorGroup = anchorGroup

        return headView
    }
    
    //实现UICollectionViewDelegateFlowLayout 协议中的方法 改变某一个区Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: gItemW, height: gProttyItemH)
            
        }else{
            return CGSize(width: gItemW, height: gNormalItemH)
        }
    }
    
    
}


