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
        collectionView.frame = self.bounds
        
        
    }
    
    //MARK:-对外暴露的方法 用于接受pageTitleView的点击
    func pageTitleViewClick(selectedIndex:Int){
//        GKBLog(message: selectedIndex)
        starOffsetX = CGFloat(selectedIndex)*gScreenW
        currentIndex = selectedIndex
        let indexPath = IndexPath(item: selectedIndex, section: 0)
//        GKBLog(message: indexPath)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
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
        for view in cell.subviews {
            view.removeFromSuperview()
          
        }
        //2.给Cell设置内容
        cell.backgroundColor = UIColor.clear
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds

        childVc.view.backgroundColor = UIColor.blue
        cell.contentView.addSubview(childVc.view)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GKBLog(message: indexPath)
       
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        starOffsetX = scrollView.contentOffset.x
        isTitleCklic = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isTitleCklic {
            return
        }
        var progress : CGFloat = 0
        var souceIndex = 0
        var tagetIndex = 0
        let curentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
//        print("starOffSet    \(starOffsetX),    curentOffset:   \(curentOffSetX)")
        if  curentOffSetX>starOffsetX {
            GKBLog(message: starOffsetX)
            progress = (curentOffSetX/scrollViewW) - floor(curentOffSetX/scrollViewW)
            souceIndex = Int(starOffsetX/scrollViewW)
            tagetIndex = souceIndex + 1
            if tagetIndex >= childVcs.count {
                tagetIndex = childVcs.count - 1
            }
            if (curentOffSetX - starOffsetX) == scrollViewW  {
                progress = 1
                souceIndex = tagetIndex
            }
            
        }else{
            progress = 1 - ((curentOffSetX/scrollViewW) - floor(curentOffSetX/scrollViewW))
            tagetIndex = Int(curentOffSetX/scrollViewW)
            souceIndex = tagetIndex + 1
            if souceIndex >= childVcs.count {
                souceIndex = childVcs.count - 1
            }
            if (curentOffSetX - starOffsetX) == -scrollViewW{
                progress = 1
                souceIndex = tagetIndex
            }
        }
        
//        guard progress == 1.0 else { return }
//         delegate?.pagecontentViewScroll(pagecontentView: self, scroToIndex: tagetIndex)
        delegate?.pagecontentViewScroll(pagecontentView: self, souceToIndex: souceIndex, tagateIndex: tagetIndex, progress: progress)

       
        print("progress:\(progress)),   tagetIndes:\(tagetIndex),   souceIndex:\(souceIndex) ,  scroViewW:\(scrollViewW)")
      
       
    }
}
