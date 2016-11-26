//
//  GKBPageTittleView.swift
//  LIveBroadcast
//
//  Created by 盖凯宾 on 16/11/23.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

protocol PageTitleDelegate: class {
    func pageTiltleDelegate(pageTitleView:GKBPageTittleView, selectedIndex:Int)
}



private let scroLineH : CGFloat = 2.0


class GKBPageTittleView: UIView {
    var tittles  = [String]()
    private lazy var titleLables : [UILabel] = [UILabel]()
    var currentIndex = 0
    private var scroLine : UIView?
    weak var delegate : PageTitleDelegate?
    
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
            
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titltLabelCklick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
            
            
    
        }
        
        setTitleBottomAndScroLine()
    }
    
    @objc private func titltLabelCklick(tapGes:UITapGestureRecognizer) {
        GKBLog(message: "title点击了")
        guard  let tagetLabel = tapGes.view as? UILabel   else{return}
        if tagetLabel.tag == currentIndex {return}
        let oldLabel = titleLables[currentIndex]
        tagetLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
         scroLine?.frame.origin.x = tagetLabel.frame.origin.x
        currentIndex = tagetLabel.tag

       delegate?.pageTiltleDelegate(pageTitleView: self, selectedIndex: currentIndex)    
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
        firstLable.textColor = UIColor.orange
        let scroLine = UIView()
        scroLine.backgroundColor = UIColor.orange
        scroLine.frame = CGRect(x: firstLable.frame.origin.x, y: firstLable.frame.height, width: firstLable.frame.width, height: frame.height-bottomLineH)
        self.scroLine = scroLine
        scroView.addSubview(scroLine)
        
        
    }
    
    //MARK:-外部暴露方法  用于接受滚动试图的代理切换label
    func changeLabelTexColorAndLineX(souceIndex: Int, tagetIndex : Int, progress: CGFloat){
        let oldLabel = titleLables[souceIndex]
        let tagetLabel = titleLables[tagetIndex]
//        oldLabel.textColor = UIColor.darkGray
//        tagetLabel.textColor = UIColor.orange
        let moveX = progress * (tagetLabel.frame.origin.x - oldLabel.frame.origin.x)
        scroLine?.frame.origin.x = oldLabel.frame.origin.x + moveX
      
    }
}

