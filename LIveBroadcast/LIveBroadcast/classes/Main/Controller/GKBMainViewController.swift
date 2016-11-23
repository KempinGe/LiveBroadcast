//
//  GKBMainViewController.swift
//  LIveBroadcast
//
//  Created by 盖凯宾 on 16/11/22.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit

class GKBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildControlers(storyboadName: "Home")
        addChildControlers(storyboadName: "Mine")
        addChildControlers(storyboadName: "Follow")
        addChildControlers(storyboadName: "Live")
    }
   
    private func addChildControlers(storyboadName:String)  {
        let childVc = UIStoryboard(name: storyboadName, bundle: nil).instantiateInitialViewController()
        guard (childVc != nil) else {
            return
        }
        addChildViewController(childVc!)
    }
  

}
