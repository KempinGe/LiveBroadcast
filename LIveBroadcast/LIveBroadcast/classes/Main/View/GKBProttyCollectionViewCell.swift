//
//  GKBProttyCollectionViewCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/7.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Kingfisher

class GKBProttyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var anchorNameLabel: UILabel!
    
    @IBOutlet weak var peapleCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UIButton!
    var anchorRoom : GKBAnchorModel?{
        didSet{
            guard let anchorRoom = anchorRoom else { return  }
            peapleCountLabel.text = "\(anchorRoom.online)人在线"
            anchorNameLabel.text = anchorRoom.nickname
            locationLabel.titleLabel?.text = anchorRoom.anchor_city
            coverImageView.kf.setImage(with: URL(string :anchorRoom.vertical_src))
        }
    }
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
       backgroundColor = UIColor.white
    }


}
