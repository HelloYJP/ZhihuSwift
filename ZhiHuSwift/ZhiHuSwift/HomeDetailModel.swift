//
//  HomeDetailModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/19.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HomeDetailModel: NSObject {
    
    var detailModel:HomeDetailStory?
    
    var comments:Int = 0
    var popularity:Int = 0
    
    func loadHomeDetailData(detailId:Int,completion:()->Void){
    
        let urlStr = "http://news-at.zhihu.com/api/4/news/"
        
        SVProgressHUD.show()
        
        Alamofire.request(.GET, urlStr + String(detailId)).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else
            {
                print("home详情数据获取失败")
                SVProgressHUD.dismiss()
                return
            }
            
            let jsonData = JSON(resultData.value!)
            
            if jsonData["image"] != nil{
                
                self.detailModel = HomeDetailStory(id: jsonData["id"].int!, title: jsonData["title"].string!, css: jsonData["css"].arrayObject as! [String], image: jsonData["image"].string!, body: jsonData["body"].string!)
            }
            else{
                self.detailModel = HomeDetailStory(id: jsonData["id"].int!, title: jsonData["title"].string!, css: jsonData["css"].arrayObject as! [String], image: "", body: jsonData["body"].string!)
            }
            
            completion()
            
            SVProgressHUD.dismiss()
        }
    }
    
    
    func loadHomeDetailExtraData(detailId:Int,completion:()->Void){
    
        let urlStr = "http://news-at.zhihu.com/api/4/story-extra/"
        
        Alamofire.request(.GET, urlStr + String(detailId)).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("新闻额外信息获取失败")
                return
            }
            
            let jsonData = JSON(resultData.value!)
                        
            self.popularity = jsonData["popularity"].int!
            self.comments = jsonData["comments"].int!
            
            completion()
        }
    }
    
    
    func loadHtmlForWebView() -> String{
    
        return "<html><head><link rel=\"stylesheet\" href=\((detailModel?.css?.first)!)></head><body>\((detailModel?.body)!)</body></html>"
    }
    
}


struct HomeDetailStory {
    
    var id:Int = 0
    var title:String?
    var css:[String]?
    var image:String?
    var body:String?
    
    init(id:Int,title:String,css:[String],image:String,body:String)
    {
        self.id    = id
        self.title = title
        self.css   = css
        self.image = image
        self.body  = body
    }
}


