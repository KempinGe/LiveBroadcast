//
//  GKBAnchorModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/8.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBAnchorModel: NSObject {
    
    var room_name : String = ""
    var room_id : String = ""
    var game_name : String = ""
    var vertical_src : String = ""
    var nickname : String = ""
    var isVertical : Int = 0
    var online : Int = 0
    var anchor_city : String = ""
    var avatar_small : String = ""
    
    
    init(dict : [String : Any]) {
        super.init()
       
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
        
    }
    

}
