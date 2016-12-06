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
private let gItemH = gItemW * 4/3
private let gHeaderViewH : CGFloat = 50

private let gNormalItemID = "gNormalItemID"
private let gHeaderViewID = "gHeaderViewID"


class GKBRecomentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUi()
    }

    //MARK:-懒加载创建collectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = gLineSpacing
        layout.minimumInteritemSpacing = gLineSpacing
        layout.itemSize = CGSize(width: gItemW, height: gItemH)
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
        
        
        
        //注册collectionView分区头的试图
        collectionView.register( UINib(nibName: "GKBCollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gHeaderViewID)
        
        //设置collectionView随着父试图的缩放而缩放
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}

//MARK:- collectionView的数据源方法
extension GKBRecomentViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if  section == 0 { return 8 }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellItem = collectionView.dequeueReusableCell(withReuseIdentifier: gNormalItemID, for: indexPath)
        
        
        return cellItem
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: gHeaderViewID, for: indexPath)
        
        return headView
    }
}
