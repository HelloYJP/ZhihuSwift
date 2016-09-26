//
//  ThemeDetailModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/19.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/*
class ThemeDetailModel: NSObject {

    
    var themeDetailStory:ThemeDetailStory?
    
    func loadThemeDetailData(detailId:Int,completion:()->Void){
        
        let urlStr = "http://news-at.zhihu.com/api/4/news/"
    
        Alamofire.request(.GET, urlStr + String(detailId)).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("主题详情内容获取失败")
                return
            }
            
            let jsonData = JSON(resultData.value!)
            
            self.themeDetailStory = ThemeDetailStory(id: jsonData["id"].int!, title: jsonData["title"].string!, css: jsonData["css"].arrayObject as! [String], body: jsonData["body"].string!)
            
            
            completion()
            
            print(jsonData)
        }
    }
    
    
    func loadHtmlForThemeWebView()->String{
        
        return "<html><head><link rel=\"stylesheet\" href=\((themeDetailStory?.css?.first)!)></head><body>\((themeDetailStory?.body)!)</body></html>"
    }
}


struct ThemeDetailStory {
    var id:Int = 0
    var title:String?
    var css:[String]?
    var body:String?
    
    
    init(id:Int,title:String,css:[String],body:String)
    {
        self.id    = id
        self.title = title
        self.css   = css
        self.body  = body
    }
}

*/