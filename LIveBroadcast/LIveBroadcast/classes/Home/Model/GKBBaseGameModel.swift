//
//  GKBBaseGameModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBBaseGameModel: NSObject {
    
    var tag_id : String = ""
    var icon_url  : String = ""
    var tag_name : String = ""
    
    init(dict : [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
