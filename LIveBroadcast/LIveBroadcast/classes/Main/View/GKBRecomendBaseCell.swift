//
//  GKBRecomendBaseCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBRecomendBaseCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var pepleOnlineLabel: UILabel!
    
    var anchorRoom : GKBAnchorModel?{
        didSet{
            
            guard let anchorRoom = anchorRoom else { return }
            anchorNameLabel.text = "\(anchorRoom.online)"
            anchorNameLabel.text = anchorRoom.nickname
            coverImageView.kf.setImage(with: URL(string :anchorRoom.vertical_src))
            if anchorRoom.online > 10000 {
                pepleOnlineLabel.text = "\(Int(anchorRoom.online/10000))万人在线"
            }else{
                pepleOnlineLabel.text = "\(anchorRoom.online)人在线"
            }
        }
    }
 

}
