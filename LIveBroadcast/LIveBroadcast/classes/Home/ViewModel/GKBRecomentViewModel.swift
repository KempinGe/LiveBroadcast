//
//  GKBRecomentViewModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/8.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBRecomentViewModel: BaseViewModel {
    
    lazy var roomGroups : [GKBGroupModel] = [GKBGroupModel]()
    lazy var verticalGroup : GKBGroupModel = GKBGroupModel()
    let hotGameGroup : GKBGroupModel = GKBGroupModel()
    
    lazy var carouselRooms : [GKBCarouselModel] = [GKBCarouselModel]()
    
    func requestData(finishCallBack : @escaping ()->()) {
        
        let timelimite = "\(Int(Date().timeIntervalSince1970))"
        let parameter = ["limit" : "4", "offset": "0","client_sys": "ios" ,"time" : timelimite]

        
        //1. 热门游戏数据请求   接口:接口http://capi.douyucdn.cn/api/v1/getHotCate
       
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        GKBNetworkTool.request(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameter, finishBlock:{(resulte) in
            //limit=4&client_sys=ios&offset=0&time=1481186624
            guard let values = resulte as? [String : Any] else { return }
            guard let groups = values["data"] as? [[String : Any]] else{return}
            self.hotGameGroup.tag_name = "热门"
            self.hotGameGroup.icon_url = "https://staticlive.douyucdn.cn/upload/game_cate/f0a531a7198cac2ba0747c435644d690.jpg"
            GKBLog(message: groups.count)
            for dict in groups {
                let anchorRoom = GKBAnchorModel(dict: dict)
            self.hotGameGroup.anchorRooms.append(anchorRoom)

            }
          
             GKBLog(message: "请求数据1")
            dispatchGroup.leave()
        })
        
        
        //2. 颜值数据接口http://capi.douyucdn.cn/api/v1/getVerticalRoom
        dispatchGroup.enter()
        GKBNetworkTool.request(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameter, finishBlock:{(result) in
//            
//            guard let values = resulte as? [String : NSObject] else { return }
//            GKBLog(message: values)
//            guard let groups = values["data"] as? [[String : NSObject]] else{return}
            guard let resultDict = result as? [String : Any] else { return }
           
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            self.verticalGroup.tag_name = "颜值"
            self.verticalGroup.icon_url = "https://staticlive.douyucdn.cn/upload/game_cate/c0c66cb41973d700b120826fd9e9016d.jpg"
        
//            for dict in dataArray {
//                let anchorRoom = GKBAnchorModel(dict: dict)
//                self.verticalGroup.anchorRooms.append(anchorRoom)
//            }
             self.verticalGroup.anchorRooms.removeAll()
            for  x in 0 ..< 4 {
                let anchorRoom = GKBAnchorModel(dict: dataArray[x])
               self.verticalGroup.anchorRooms.append(anchorRoom)
            }
            
            GKBLog(message: "请求数据2")
            dispatchGroup.leave()
        })
        
        
        
        //3.大数据数据(第一组热门数据)http://capi.douyucdn.cn/api/v1/getHotCate
        dispatchGroup.enter()
//        reloadData(URL: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameter, finishedCallBack: {
//            dispatchGroup.leave()
//        })
    
        GKBNetworkTool.request(type: .GET, URL: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameter, finishBlock:{(resulte) in
            
            guard let values = resulte as? [String : Any] else { return }
            guard let groups = values["data"] as? [[String : Any]] else{return}
            
            for dict in groups {
                let group = GKBGroupModel(dict: dict)
             
                self.roomGroups.append(group)
          
            }
            GKBLog(message: "请求数据3")
            dispatchGroup.leave()
    })
        
        
        
        dispatchGroup.notify(queue: DispatchQueue.main, execute:
            {
                GKBLog(message: "请求到所有数据")
                self.roomGroups.remove(at: 1)
                self.roomGroups.insert(self.verticalGroup, at: 0)
                self.roomGroups.insert(self.hotGameGroup, at: 0)
                GKBLog(message: self.roomGroups.count)
              
                finishCallBack()
        } )
  
    }
    
    //请求无限轮播数据
    func requestCarouselData(finishedCallBack : @escaping() -> ()) {
        
     
        
        GKBNetworkTool.request(type: .GET, URL:  "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"], finishBlock: { (result) in
         
            guard let resut = result as? [String : Any] else { return }
            guard let carouserData = resut["data"] as? [[String : Any]] else { return }
            
            for dict in carouserData {
                let carouselRoom = GKBCarouselModel(dict: dict)
                self.carouselRooms.append(carouselRoom)
            }
            
            finishedCallBack()
            
        })
    }
    
}
