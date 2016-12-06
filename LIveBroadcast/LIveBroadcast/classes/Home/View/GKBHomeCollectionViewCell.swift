//
//  GKBHomeCollectionViewCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/6.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.white
        coverImageView.layer.cornerRadius = 5.0
        coverImageView.layer.masksToBounds = true
    }

}
