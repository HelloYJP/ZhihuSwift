//
//  HomeModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/8/24.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HomeModel: NSObject {
    
    
    var dateStr:String?             //当前日期
    var listNewsData:[[Story]] = [] //新闻数据
    var listLoopData:[TopStory] = []
    var listNewsId:[Int] = []
    var listDate:[String] = []

    
    //Mark: - 最新数据
    func loadLastedHomeData(completion:()->Void){
        
        let urlStr:String = "http://news-at.zhihu.com/api/4/news/latest"
        
        SVProgressHUD.show()
        
        Alamofire.request(.GET, urlStr).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil  else{
                print("home数据获取失败")
                SVProgressHUD.dismiss()
                return
            }
            
            let jsonData = JSON(resultData.value!)
            
            self.dateStr = jsonData["date"].string
            let jsonTopData = jsonData["top_stories"]
            let jsonStroiesData = jsonData["stories"]
            
            if self.listDate.count != 0{
                self.listDate.removeAll()
            }
            
            if self.listLoopData.count != 0 {
                self.listLoopData.removeAll()
            }
            
            if self.listNewsData.count != 0{
                self.listNewsData.removeAll()
            }
            
            if self.listNewsId.count != 0 {
                self.listNewsId.removeAll()
            }
            
            self.listDate.append(self.dateStr!)
            
            
            for topData in jsonTopData
            {
                self.listLoopData.append(TopStory(id: topData.1["id"].int!, title: topData.1["title"].string!, image: topData.1["image"].string!, type: topData.1["type"].int!, ga_prefix: topData.1["ga_prefix"].string!))
            }
            
            var tempArr = [Story]()
            
            for otherData in jsonStroiesData
            {
               tempArr.append(Story(id: otherData.1["id"].int!, title: otherData.1["title"].string!, type: otherData.1["type"].int!, images: otherData.1["images"].arrayObject as! [String], ga_prefix: otherData.1["ga_prefix"].string!))
                
                self.listNewsId.append(otherData.1["id"].int!)
            }
            
            self.listNewsData.append(tempArr)
            
            completion()
            SVProgressHUD.dismiss()
        }
    }
    
    //MARK: - 过往数据
    func loadPreviousHomeData(completion:()->Void){
    
        let urlStr = "http://news.at.zhihu.com/api/4/news/before/"
        
        Alamofire.request(.GET, urlStr + dateStr!).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("home过往数据获取失败")
                return
            }
            
            let data = JSON(resultData.value!)
            
            self.dateStr = data["date"].string!
            let jsonStoriesData = data["stories"]
            
    
            self.listDate.append(self.dateStr!)

            var tempArr = [Story]()
            for storyData in jsonStoriesData
            {
                tempArr.append(Story(id: storyData.1["id"].int!, title: storyData.1["title"].string!, type: storyData.1["type"].int!, images: storyData.1["images"].arrayObject as! [String], ga_prefix: storyData.1["ga_prefix"].string!))
                self.listNewsId.append(storyData.1["id"].int!)
            }
            
            self.listNewsData.append(tempArr)
            
            completion()
        }
    }
    
    //MARK: - 轮播图数据
    
    func loopImageTitles() -> [String]{
        
        var imgTitles:[String] = []
        for topStory in listLoopData
        {
            imgTitles.append(topStory.title!)
        }
        return imgTitles
    }
    
    func loopImagesUrls() -> [String]{
        
        var imgUrls:[String] = []
        for topStory in listLoopData
        {
            imgUrls.append(topStory.image!)
        }
        return imgUrls
    }
    
    func numberOfLoopImages() -> Int{
        return loopImagesUrls().count
    }
    
    
    //MARK: -
    func numberOfSections() -> Int{
        return self.listDate.count
    }
    
    func numberOfRowInSection(section:Int) -> Int{
        
        guard self.listNewsData.count != 0 else{
            return 1
        }
        
        return self.listNewsData[section].count
    }

    func storyAtIndexPath(indexPath:NSIndexPath) -> Story{
        return self.listNewsData[indexPath.section][indexPath.row]
    }
    
    func dateStringOfSection(section:Int) -> String{
        
        let format = NSDateFormatter()
        format.dateFormat = "yyyyMMdd"
        let date = format.dateFromString(self.listDate[section])
        format.locale = NSLocale(localeIdentifier: "zh-CN")
        format.dateFormat = "MM月dd日 EEEE"
        let dateString = format.stringFromDate(date!)
        return dateString
    }
    
    //MARK: - 若有上一篇，则返回id
    func  getPreviousNewsId(currentId:Int) -> Int{
        
        let index = self.listNewsId.indexOf(currentId)
        
        if index > 0{
            return self.listNewsId[index! - 1]
        }
        return 0
    }
    
    //MARK: - 返回下一篇id
    func getNextNewsId(currentId:Int) -> Int{
        
        let index = self.listNewsId.indexOf(currentId)
        if  index < (self.listNewsId.count-1){
            return self.listNewsId[index! + 1]
        }
        return currentId
    }
    
}


struct TopStory {
    var id:Int = 0
    var title:String?
    var image:String?
    var type:Int = 0
    var ga_prefix:String?
    
    
    init(id:Int,title:String,image:String,type:Int,ga_prefix:String){
        self.id = id
        self.title = title
        self.image = image
        self.type = type
        self.ga_prefix = ga_prefix
    }
}

struct Story {
    var id:Int = 0
    var title:String?
    var type:Int = 0
    var images:[String]?
    var ga_prefix:String?
    
    init(id:Int,title:String,type:Int,images:[String],ga_prefix:String){
        self.id = id
        self.title = title
        self.type = type
        self.images = images
        self.ga_prefix = ga_prefix
    }
}



