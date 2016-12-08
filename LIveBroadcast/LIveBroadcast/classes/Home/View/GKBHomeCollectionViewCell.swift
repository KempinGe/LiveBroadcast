//
//  GKBHomeCollectionViewCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/6.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Kingfisher

class GKBHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!

    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchorRoom : GKBAnchorModel?{
        didSet{
            guard let anchorRoom = anchorRoom else { return }
            anchorNameLabel.text = "\(anchorRoom.online)"
            anchorNameLabel.text = anchorRoom.nickname
            coverImageView.kf.setImage(with: URL(string :anchorRoom.vertical_src))
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.white
      
        
    
    }
  

}
