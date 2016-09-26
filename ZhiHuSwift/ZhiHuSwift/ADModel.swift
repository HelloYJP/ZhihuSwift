//
//  ADModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/6.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ADModel: NSObject {
    
    var text:String?
    var img:String?
    

    class func loadADData(completion:(model:ADModel?,error:ErrorType?) ->Void){
        
        let urlStr = "http://news-at.zhihu.com/api/4/start-image/1080*1776"
        Alamofire.request(.GET, urlStr).responseJSON { (_, _, resultJson) -> Void in

            guard resultJson.error == nil else
            {
                print("获取数据失败")
                completion(model: nil, error: resultJson.error)
                return
            }
            
        
            let data = JSON(resultJson.value!).dictionaryObject
            let adModel = ADModel()
            adModel.text = data!["text"] as? String
            adModel.img = data!["img"] as? String
            
            completion(model: adModel, error: nil)
    
        }
    }
}
