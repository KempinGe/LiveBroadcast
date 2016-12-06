//
//  GKBPageContentView.swift
//  LIveBroadcast
//
//  Created by KempinGe on 16/11/23.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

protocol PagecontentViewScrollDelegate: class {
    func pagecontentViewScroll(pagecontentView:GKBPageContentView, souceToIndex:Int, tagateIndex:Int, progress:CGFloat)
}

private let contentCellID = "colletionCellId"
class GKBPageContentView: UIView {
    var childVcs : [UIViewController]
    private weak var parentVc : UIViewController?
    var starOffsetX : CGFloat = 0
    weak var delegate : PagecontentViewScrollDelegate?
    var currentIndex = 0
    var isTitleCklic = false
    //MARK:- 创建collectionView
    private lazy var collectionView : UICollectionView = {[weak self] in
     //创建layout
    let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        GKBLog(message: "--------------------")
        GKBLog(message: layout.itemSize)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], prentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = prentVc
        super.init(frame: frame)
        setUpUi()
      
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
    
    //MARK:-对外暴露的方法 用于接受pageTitleView的点击
    func pageTitleViewClick(selectedIndex:Int){
       
        let offsetX = CGFloat(selectedIndex) * frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
        GKBLog(message: "切换试图到\(selectedIndex) offset = \(offsetX)")
    }

}


//MARK: - collectionView 的datasouce 与代理
extension GKBPageContentView : UICollectionViewDelegate,UICollectionViewDataSource {
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //解决重用的重复加载View问题
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
          
        }
        //2.给Cell设置内容
        cell.backgroundColor = UIColor.clear
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds

        cell.contentView.addSubview(childVc.view)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GKBLog(message: indexPath)
       
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTitleCklic = false
        starOffsetX = scrollView.contentOffset.x
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isTitleCklic { return }
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > starOffsetX{ // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - starOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
//        guard progress == 1.0 else { return }
//         delegate?.pagecontentViewScroll(pagecontentView: self, scroToIndex: tagetIndex)
        delegate?.pagecontentViewScroll(pagecontentView: self, souceToIndex: sourceIndex, tagateIndex: targetIndex, progress: progress)

       
        print("progress:\(progress)),   tagetIndes:\(targetIndex),   souceIndex:\(sourceIndex) ,  scroViewW:\(scrollViewW)")
      
       
    }
}
