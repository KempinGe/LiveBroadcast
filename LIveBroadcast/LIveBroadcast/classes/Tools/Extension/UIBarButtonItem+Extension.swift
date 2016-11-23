//
//  UIBarButtonItem+Extension.swift
//  LIveBroadcast
//
//  Created by 盖凯宾 on 16/11/22.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    /** 扩充的类方法
    class func creatItem(imageName:String, highlightName:String, size : CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: highlightName), for: UIControlState.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
    
    }
 */
    //便利构造方法  需要调用设计构造函数
    convenience init(imageName:String, highlightName:String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        if highlightName != "" {
            btn.setImage(UIImage.init(named: highlightName), for: UIControlState.highlighted)

        }
        if size == CGSize.zero {
            btn.sizeToFit()
            print(btn.frame.size)
        
        }else{
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
            
        }
        self.init(customView:btn)
    }
    
    
}
