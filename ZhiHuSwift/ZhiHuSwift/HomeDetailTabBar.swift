//
//  HomeDetailTabBar.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/19.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit


protocol HomeDetailTabBarDelegate
{
    func detailBack()
    func detailNext()
    func detailVote()
    func detailShare()
    func detailComment()
}

class HomeDetailTabBar: UIView {

    
    var delegate:HomeDetailTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        configUI()
    }
    
    func configUI(){
        
        let width:CGFloat = ScreenWidth/5
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1))
        line.backgroundColor = UIColor.lightGrayColor()
        addSubview(line)
        
        for index in 0..<5{
        
            let btn = HomeDetailTarbarButton(frame: CGRect(x: width * CGFloat(index), y: CGRectGetMaxY(line.frame), width: width, height: 49))
            btn.tag = index
            configBtnImage(btn)
            
            if index == 2{
                btn.setTitleColor(UIColor.grayColor(), forState: .Normal)
            }
            else if index == 4{
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
            
            btn.addTarget(self, action: "btnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            addSubview(btn)
        }
    }
    
    
    func setPopularityAndComments(Popularity:Int,Comments:Int){
        
        let popularityBtn = self.viewWithTag(2) as! HomeDetailTarbarButton
        popularityBtn.setTitle(String(Popularity), forState: .Normal)
        
        let commentsBtn = self.viewWithTag(4) as! HomeDetailTarbarButton
        commentsBtn.setTitle(String(Comments), forState: .Normal)
    }
    
    func btnAction(sender:UIButton){
    
        switch sender.tag{
        case 0:
            self.delegate?.detailBack()
        case 1:
            self.delegate?.detailNext()
        case 2:
            self.delegate?.detailVote()
        case 3:
            self.delegate?.detailShare()
        case 4:
            self.delegate?.detailComment()
        default:
            print("tarbar点击错误")
        }
    }
    
    
    func configBtnImage(sender:UIButton){
        
        switch sender.tag{
        case 0:
            sender.setImage(UIImage(named: "detail_Back"), forState: .Normal)
        case 1:
            sender.setImage(UIImage(named: "detail_Next"), forState: .Normal)
        case 2:
            sender.setImage(UIImage(named: "detail_Voted"), forState: .Normal)
        case 3:
            sender.setImage(UIImage(named: "detail_Share"), forState: .Normal)
        case 4:
            sender.setImage(UIImage(named: "detail_Comment"), forState: .Normal)
        default:
            print("tarbar点击错误")
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
