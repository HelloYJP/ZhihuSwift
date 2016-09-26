//
//  LeftModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/12.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeftModel: NSObject {
    
    var limit:Int?
    var others:[themeModel] = []
    
    
    init(limit:Int,dataArr:JSON) {
        super.init()
        self.limit = limit
        
        for index in 0..<dataArr.count
        {
            let model = dataArr[index]
            self.others.append(themeModel(name: model["name"].string!, id: model["id"].int!, description: model["description"].string!, thumbnail: model["thumbnail"].string!, color: model["color"].int!))
        }
    }
    
    
    class func loadThemesData(completion:(leftModel:LeftModel)->Void){
    
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/themes").responseJSON { (_,_, resultData) -> Void in
            
            guard resultData.error == nil else
            {
                print("Left获取数据失败")
                return
            }
            
            let data = JSON(resultData.value!)
            let lim = data["limit"]
            let dataArr = data["others"]
            
            let leftModel = LeftModel(limit: lim.int!, dataArr: dataArr)
            
            completion(leftModel: leftModel)
        }
    }
}

struct themeModel {
    var name:String
    var id:Int
    var description:String
    var thumbnail:String
    var color:Int
    
    
    init(name:String,id:Int,description:String,thumbnail:String,color:Int){
        self.name = name
        self.id = id
        self.description = description
        self.thumbnail = thumbnail
        self.color = color
    }
}
