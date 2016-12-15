//
//  GKBCarouselView.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/11.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Kingfisher

private let gCarouselItemID : String = "gCarouselItemID"
class GKBCarouselView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
     var carouselTimer : Timer?
    
    var carouselRooms : [GKBCarouselModel]? {
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = carouselRooms?.count ?? 0
            collectionView.setContentOffset(  CGPoint(x: CGFloat(pageControl.numberOfPages * 15) * bounds.width, y: 0), animated: false)
            removeTimer()
            addTimer()
            
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: gCarouselItemID)
        collectionView.dataSource = self
        collectionView.delegate = self
        autoresizingMask = []
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //MARK:- laoutSubViews 里面才能拿到正确的尺寸
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
       
        // 剩下的去XIB设置了
    }
    
    class func laodCarouselView() -> GKBCarouselView  {
        return Bundle.main.loadNibNamed("GKBCarouselView", owner: nil, options: nil)?.first as! GKBCarouselView
    
    }
    
    
    //MARK:-加载定时器
    func addTimer(){

        carouselTimer = Timer(timeInterval: 2.5, target: self, selector: #selector(GKBCarouselView.timeRepireFunc), userInfo: nil, repeats: true)
       RunLoop.main.add(carouselTimer!, forMode: RunLoopMode.commonModes)
    }
    
    //移除定时器
     func removeTimer() {
        carouselTimer?.invalidate()
        carouselTimer = nil
        
    }
    
   @objc private func timeRepireFunc() {
   
        var offSet = collectionView.contentOffset.x
        offSet += collectionView.frame.width
        collectionView.setContentOffset( CGPoint(x: offSet, y: 0), animated: true)
        pageControl.currentPage += 1
    }
}
extension GKBCarouselView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (carouselRooms?.count  ?? 0 ) * 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: gCarouselItemID, for: indexPath)
        let image : UIImageView = UIImageView()
        image.frame = CGRect(origin: CGPoint.zero, size: item.contentView.frame.size)
     
        item.contentView.addSubview(image)
        item.contentView.backgroundColor = UIColor.blue
        guard let carousel = carouselRooms?[indexPath.item % (carouselRooms?.count ?? 1)]  else {return item}
        guard let url = URL(string :carousel.pic_url )else {return item}
        image.kf.setImage(with: url)
       
        item.contentView.backgroundColor = UIColor.blue
        return item
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let x = collectionView.contentOffset.x
        pageControl.currentPage = Int(x / scrollView.bounds.width) % pageControl.numberOfPages
 
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
      
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

