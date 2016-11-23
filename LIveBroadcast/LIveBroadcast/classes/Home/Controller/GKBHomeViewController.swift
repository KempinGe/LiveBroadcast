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

    
    
    private lazy var pageTittleView : GKBPageTittleView = {
        let tittles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y: gstatuH+gNavH, width: gScreenW, height: tittleViewH)
        let tittleView = GKBPageTittleView(frame: frame, tittles: tittles)
//        tittleView.backgroundColor = UIColor.purple
        return tittleView
        
    }()
    
    //MARK:-
    private lazy var pageContentView : GKBPageContentView = { [weak self] in
        let contentH = gScreenH - tittleViewH - gstatuH - gNavH
        let contentFrame = CGRect(x: 0, y: gstatuH+gNavH+tittleViewH, width: (self?.view.frame.width)!, height: contentH)
        var childVcs : [UIViewController] = [UIViewController]()
        let arr : [CGFloat] = [233.0,155.0,177.77, 20.33]
        for var x in 0..<4{
            let vc = UIViewController()
            var a =  CGFloat(arr[x]/255)
            vc.view.backgroundColor = UIColor.init(red: a, green: a, blue: a, alpha: 0.5)
            childVcs.append(vc)
        }
        
        let contentView = GKBPageContentView(frame: contentFrame, childVcs: childVcs, prentVc: self!)
        
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
