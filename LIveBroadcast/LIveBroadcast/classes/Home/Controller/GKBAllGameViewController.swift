//
//  GKBAllGameViewController.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/13.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBAllGameViewController: UIViewController {
    var gameVm : GKBGamneViewModel = GKBGamneViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        gameVm.reloadGameData(finishedCallBack: {
            
        })
       view.backgroundColor = UIColor.purple
    }

  



}
