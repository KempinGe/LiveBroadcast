//
//  GKBHomeViewController.swift
//  LIveBroadcast
//
//  Created by 盖凯宾 on 16/11/22.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

private let tittleViewH : CGFloat = 40
class GKBHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        view.addSubview(pageTittleView)
        view.addSubview(pageContentView)
    }

    
    
     lazy var pageTittleView : GKBPageTittleView = {[weak self] in
        let tittles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y: gstatuH+gNavH, width: gScreenW, height: tittleViewH)
        let tittleView = GKBPageTittleView(frame: frame, tittles: tittles)
        tittleView.delegate = self
//        tittleView.backgroundColor = UIColor.purple
        return tittleView
        
    }()
    
    //MARK:-
     lazy var pageContentView : GKBPageContentView = { [weak self] in
        let contentH = gScreenH - tittleViewH - gstatuH - gNavH
        let contentFrame = CGRect(x: 0, y: gstatuH+gNavH+tittleViewH, width: (self?.view.frame.width)!, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(GKBRecomentViewController())
        for var x in 0..<3{
           let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            childVcs.append(vc)
        }
        GKBLog(message: childVcs)
        let contentView = GKBPageContentView(frame: contentFrame, childVcs: childVcs, prentVc: self!)
        contentView.delegate = self
        GKBLog(message: contentView.frame)

        return contentView
    }()
}

extension GKBHomeViewController {
     func setUpView() {
        setUpNav()
        
        //设置不自动调整内边距
        automaticallyAdjustsScrollViewInsets = false
    }
    
    
    private func setUpNav() {
//        let  leftBtnItem = UIButton()
//        leftBtnItem.setImage(UIImage.init(named: "logo"), for: UIControlState.normal)
//        leftBtnItem.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtnItem)
      
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
//        let  historyItem = nil
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highlightName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highlightName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
    }
    
    
}

//MARK:-pagetiltleView与pageContentView的代理
extension GKBHomeViewController : PageTitleDelegate, PagecontentViewScrollDelegate{
    func pagecontentViewScroll(pagecontentView: GKBPageContentView, souceToIndex: Int, tagateIndex: Int, progress: CGFloat) {
        pageTittleView.changeLabelTexColorAndLineX(souceIndex: souceToIndex, tagetIndex: tagateIndex, progress: progress)
        
    }

    func pageTiltleDelegate(pageTitleView: GKBPageTittleView, selectedIndex: Int) {
        pageContentView.isTitleCklic = true
        pageContentView.pageTitleViewClick(selectedIndex: selectedIndex)
    }
}
