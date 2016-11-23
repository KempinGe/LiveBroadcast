//
//  GKBPageTittleView.swift
//  LIveBroadcast
//
//  Created by 盖凯宾 on 16/11/23.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
private let scroLineH : CGFloat = 2.0
class GKBPageTittleView: UIView {
    var tittles  = [String]()
    private lazy var titleLables : [UILabel] = [UILabel]()
    
    init(frame: CGRect, tittles : [String]) {
        self.tittles = tittles
        super.init(frame: frame)
        
        setUpUi()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- 懒加载scroView
    private lazy var scroView : UIScrollView = {
        let scroView = UIScrollView()
        scroView.showsHorizontalScrollIndicator = false
        scroView.scrollsToTop = false
        scroView.bounces = false
        return scroView
    }()
    
    private func setUpUi() {
      
        addSubview(scroView)
        scroView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        let lableW = gScreenW / CGFloat(tittles.count)
        let lableH  = 40 - scroLineH
        for (index, tittle) in tittles.enumerated() {
//            GKBLog(message: index)
//            GKBLog(message: tittle)
            let lable = UILabel()
            lable.text = tittle
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
           
            let lableX = CGFloat(index)*lableW
            lable.frame = CGRect(x: lableX, y: 0, width: lableW, height: lableH)
            titleLables.append(lable)
            scroView.addSubview(lable)
    
        }
        
        setTitleBottomAndScroLine()
    }
    
    //设置titleLable的底线
    private func setTitleBottomAndScroLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)
        
        //MARK:- 添加scroLine 
        guard  let firstLable = titleLables.first else {
            return
        }
        let scroLine = UIView()
        scroLine.backgroundColor = UIColor.orange
        scroLine.frame = CGRect(x: firstLable.frame.origin.x, y: firstLable.frame.height, width: firstLable.frame.width, height: frame.height-bottomLineH)
        scroView.addSubview(scroLine)
        
        
    }

}

