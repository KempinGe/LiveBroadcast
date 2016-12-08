//
//  GKBCollectionHeaderReusableView.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/6.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBCollectionHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    var anchorGroup : GKBGroupModel? {
        didSet{
            titleLabel.text = anchorGroup?.tag_name
            guard let icon_url = anchorGroup?.icon_url  else {  return }
            guard  let imageData = NSData(contentsOf:URL(string: icon_url)!) else {
                iconImageView.image = UIImage.init(named: "")
                return
            }
           iconImageView.image = UIImage(data: imageData as Data)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
