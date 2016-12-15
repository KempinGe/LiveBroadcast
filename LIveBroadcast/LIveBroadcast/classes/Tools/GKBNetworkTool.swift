//
//  GKBNetworkTool.swift
//  LIveBroadcast
//
//  Created by KempinGe on 2016/12/7.
//  Copyright © 2016年 盖凯宾. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

class GKBNetworkTool: NSObject {
    class func request(type : MethodType, URL: String, parameters : [String : Any]? = nil , finishBlock : @escaping (_ result : AnyObject ) -> ()) {
        let methondType : HTTPMethod
        if type == .GET {
            methondType = .get
        }else
        {
            methondType = .post
        }
//        Alamofire.request(URL, method: methondType, parameters: parameters, encoding: ParameterEncoding, headers: nil)
        Alamofire.request(URL, method: methondType).responseJSON {
            (response) in
            guard let result = response.result.value else{
               GKBLog(message: response.result.error)
                return
            }
            finishBlock(result as AnyObject)
            
        }
        
    }
}
