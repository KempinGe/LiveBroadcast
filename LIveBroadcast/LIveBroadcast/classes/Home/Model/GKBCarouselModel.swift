//
//  GKBCarouselModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/11.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBCarouselModel: NSObject {
    
//    var id : String = ""
    var title : String = ""
    var pic_url : String = ""
    var tv_pic_url : String = ""
    var room : [String : NSObject]? {
        didSet{
            guard let anchorRoom = room else {
                return
            }
            carouselRoom = GKBAnchorModel(dict: anchorRoom)
        }
    }
    var carouselRoom : GKBAnchorModel?
    
   init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
