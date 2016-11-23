//
//  GKBPageContentView.swift
//  LIveBroadcast
//
//  Created by KempinGe on 16/11/23.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

private let contentCellID = "colletionCellId"
class GKBPageContentView: UIView {
     var childVcs : [UIViewController] = [UIViewController]()
    private weak var parentVc : UIViewController?
    
    //MARK:- 创建collectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
     //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
//        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], prentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = prentVc
        super.init(frame: frame)
        setUpUi()
        backgroundColor = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUi() {
        //将所有自控制器添加到父控制器中
        for vc in childVcs {
            parentVc?.addChildViewController(vc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }

}

extension GKBPageContentView : UICollectionViewDelegate,UICollectionViewDataSource {
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        GKBLog(message: childVcs.count)
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //解决重用的重复加载View问题
        for view in cell.subviews {
            view.removeFromSuperview()
          
        }
          GKBLog(message: cell)
        GKBLog(message: "sadsadasd")
        //2.给Cell设置内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        GKBLog(message: childVc.view.frame)
        cell.contentView.addSubview(childVc.view)
        return cell
    }
 
}
