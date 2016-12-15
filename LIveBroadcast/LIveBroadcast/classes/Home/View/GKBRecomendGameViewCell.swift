//
//  GKBRecomendGameViewCell.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/12.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Kingfisher

class GKBRecomendGameViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var gameAnchorRoom  : GKBGroupModel? {
        didSet{
            titleLabel.text = gameAnchorRoom?.tag_name
            guard let AnchorRoom = gameAnchorRoom  else { return }
            if AnchorRoom.icon_url == "" {
                imageView.image = UIImage(named: "home_more_btn")
            }
            guard let url = URL(string: AnchorRoom.icon_url) else { return }
            imageView.kf.setImage(with: url)
//            imageView.kf.setImage(with: <#T##Resource?#>, placeholder: <#T##Image?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> ()#>, completionHandler: <#T##CompletionHandler?##CompletionHandler?##(Image?, NSError?, CacheType, URL?) -> ()#>)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
    }

}
