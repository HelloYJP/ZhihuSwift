//
//  ThemeModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ThemeModel: NSObject {
    
    var themeStories:[ThemeStory] = []
    var themeEditors:[ThemeEditor] = []
    var background:String?
    
    func loadThemeData(themeId:Int,completion:()->Void){
    
        let urlStr = "http://news-at.zhihu.com/api/4/theme/"
        
        Alamofire.request(.GET, urlStr+String(themeId)).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("主题数据获取失败")
                return
            }
            
            let jsonData = JSON(resultData.value!)
            let jsonStories = jsonData["stories"]
            let jsonEditors = jsonData["editors"]
            
            
            if self.themeStories.count != 0 {
                self.themeStories.removeAll()
            }
            
            if self.themeEditors.count != 0 {
                self.themeEditors.removeAll()
            }
            
            self.background = jsonData["background"].string!
            
            for story in jsonStories
            {
                let storyDic = story.1.dictionaryObject
                
                if storyDic!.keys.contains("images"){
                
                    self.themeStories.append(ThemeStory(type: story.1["type"].int!, id: story.1["id"].int!, title: story.1["title"].string!, images: story.1["images"].arrayObject as! [String]))
                }
                else{
                    self.themeStories.append(ThemeStory(type: story.1["type"].int!, id: story.1["id"].int!, title: story.1["title"].string!, images:[""]))
                }
            }
            
            for editor in  jsonEditors{
                
                self.themeEditors.append(ThemeEditor(avatar: editor.1["avatar"].string!, id: editor.1["id"].int!,name: editor.1["name"].string!))
            }
            
            completion()
        }
    
    }
    
    func numberOfRowsInSection() -> Int{
        return self.themeStories.count
    }
    
    func themeStoryAtIndesPath(indexPath:NSIndexPath)->ThemeStory{
        return self.themeStories[indexPath.row]
    }
        
}


struct ThemeStory {
    var type:Int = 0
    var id:Int = 0
    var title:String?
    var images:[String]?
    
    init(type:Int,id:Int,title:String,images:[String])
    {
        self.type = type
        self.id = id
        self.title = title
        self.images = images
    }
}

struct ThemeEditor {
    var avatar:String?
    var id:Int = 0
    var name:String?

    
    init(avatar:String,id:Int,name:String)
    {
        self.avatar = avatar
        self.id = id
        self.name = name
    }
}

