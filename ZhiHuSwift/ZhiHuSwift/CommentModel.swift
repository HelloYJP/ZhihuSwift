//
//  CommentModel.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class CommentModel: NSObject {
    
    var listLongComments:[ShortComment] = []
    var listShortComments:[ShortComment] = []
    
    lazy var formatter:NSDateFormatter = {
    
        let format = NSDateFormatter()
        format.locale = NSLocale.currentLocale()
        format.dateFormat = "MM-dd HH:mm"
        return format
    }()
    
    //长评论
    func loadLongCommentData(commentId:Int,completion:()->Void){
        
        let urlStr1 = "http://news-at.zhihu.com/api/4/story/"
        let urlStr2 = "/long-comments"
        
        Alamofire.request(.GET, urlStr1 + String(commentId) + urlStr2).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("长评论获取失败")
                return
            }
            
            let jsonData = JSON(resultData.value!)
            
            for comment in jsonData["comments"]{
                
                self.listLongComments.append(ShortComment(author: comment.1["author"].string!, content: comment.1["content"].string!, id: comment.1["id"].int!, likes: comment.1["likes"].int!, time: comment.1["time"].int!, avatar: comment.1["avatar"].string!))
            }
            
            completion()
        }
    }
    
    
    //短评论
    func loadShortCommentData(commentId:Int,completion:()->Void){
    
        SVProgressHUD.show()
        
        let urlStr1 = "http://news-at.zhihu.com/api/4/story/"
        let urlStr2 = "/short-comments"
        
        Alamofire.request(.GET, urlStr1 + String(commentId) + urlStr2).responseJSON { (_, _, resultData) -> Void in
            
            guard resultData.error == nil else{
                print("短评论获取失败")
                SVProgressHUD.dismiss()
                return
            }
            
            let jsonData = JSON(resultData.value!)
            
            for comment in jsonData["comments"]{
        
                self.listShortComments.append(ShortComment(author: comment.1["author"].string!, content: comment.1["content"].string!, id: comment.1["id"].int!, likes: comment.1["likes"].int!, time: comment.1["time"].int!, avatar: comment.1["avatar"].string!))
            }
            
            completion()
            SVProgressHUD.dismiss()
        }
    }
    
    func numberRowsInSection(section:Int) -> Int{
    
        if section == 0{
            return self.listLongComments.count
        }
        return self.listShortComments.count
    }
    
    func commentAtIndexPath(indexPath:NSIndexPath) -> ShortComment{
        
        if indexPath.section == 0{
            return self.listLongComments[indexPath.row]
        }
        return self.listShortComments[indexPath.row]
    }
    
    
    //处理时间
    func getStandardTime(time:Int) -> String{
    
        let date = NSDate(timeIntervalSince1970: Double(time))
        return formatter.stringFromDate(date)
    }
    
}

struct ShortComment{
    
    var author:String?
    var content:String?
    var id:Int = 0
    var likes:Int = 0
    var time:Int = 0
    var avatar:String?
    
    init(author:String,content:String,id:Int,likes:Int,time:Int,avatar:String){
        self.author = author
        self.content = content
        self.id = id
        self.likes = likes
        self.time = time
        self.avatar = avatar
    }
}


