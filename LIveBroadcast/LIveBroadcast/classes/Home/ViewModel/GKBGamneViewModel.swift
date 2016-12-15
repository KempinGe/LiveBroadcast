//
//  GKBGamneViewModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBGamneViewModel: BaseViewModel {
    
   
    func reloadGameData(finishedCallBack : @escaping () -> ()) {
        
        reloadData(URL: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"], finishedCallBack: finishedCallBack)
    }
    

}
