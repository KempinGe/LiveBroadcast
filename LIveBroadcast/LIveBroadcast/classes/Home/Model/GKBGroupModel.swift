//
//  GKBGroupModel.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/8.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBGroupModel: GKBBaseGameModel {
    /*	room_list		[4]
     
     push_vertical_screen	:	0
     
     icon_url	:	https://staticlive.douyucdn.cn/upload/game_cate/f0a531a7198cac2ba0747c435644d690.jpg
     
     tag_name	:	英雄联盟
     
     tag_id	:	1
*/
    lazy var anchorRooms : [GKBAnchorModel] = [GKBAnchorModel]()
    
    var room_list : [[String : Any]]? {
        didSet{
         
            guard let  room_list = room_list else { return }
            for dict in room_list {
                anchorRooms.append(GKBAnchorModel(dict: dict))
            }
        }
    }
 
}
