//
//  GKBProttyCollectionViewCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/7.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Kingfisher

class GKBProttyCollectionViewCell: GKBRecomendBaseCell {

 
    @IBOutlet weak var locationBtn: UIButton!
    
    override var anchorRoom : GKBAnchorModel?{
        didSet{
            
             // 将属性传递给父类
            super.anchorRoom = anchorRoom
            
            locationBtn.titleLabel?.text = anchorRoom?.anchor_city
                   }
    }
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
       backgroundColor = UIColor.white
    }


}
