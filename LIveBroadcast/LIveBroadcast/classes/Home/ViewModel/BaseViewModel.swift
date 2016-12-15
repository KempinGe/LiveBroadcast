//
//  BaseViewModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    var gameModels : [GKBAllGameModel] = [GKBAllGameModel]()
    
    func reloadData(URL: String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () ->()) {
        GKBNetworkTool.request(type: .GET, URL: URL, parameters: parameters, finishBlock: {  (result) in
            guard let resultData = result as? [String : Any] else { return }
            guard let dataArray = resultData["data"] as? [[String : Any]] else {return}
            for dict in dataArray {
                
                let gameModel = GKBAllGameModel(dict: dict)
                self.gameModels.append(gameModel)
            }
            GKBLog(message: self.gameModels.count)
            finishedCallBack()
        })
        
    }
    
}
