//
//  LeftHeadView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/9.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class LeftHeadView: UIView {
    
    var iconBtn:IconButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //
        configUI()
        
    }

    func configUI(){
    
        iconBtn = IconButton(frame: CGRect(x: 10, y: 20, width: 200, height: 40))
        iconBtn?.setImage(UIImage(named: "fly.png"), forState: UIControlState.Normal)
        iconBtn?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        iconBtn?.setTitle("海贼王", forState: UIControlState.Normal)
        iconBtn?.titleLabel?.font = UIFont.systemFontOfSize(15)
        addSubview(iconBtn!)
        
        
        let width:CGFloat = 200/3
        for index in 0..<3
        {
            let btn = FeatureButton(frame: CGRect(x: width*CGFloat(index), y: CGRectGetMaxY((iconBtn?.frame)!)+10, width: width, height: 50))
            btn.backgroundColor = LeftVCBackgroundColor
            
            if index == 0{
                btn.setImage(UIImage(named: "leftFavour"), forState: .Normal)
                btn.setTitle("收藏", forState: .Normal)
            }else if index == 1{
                btn.setImage(UIImage(named: "leftMessage"), forState: .Normal)
                btn.setTitle("消息", forState: .Normal)
            }else{
                btn.setImage(UIImage(named: "leftSetting"), forState: .Normal)
                btn.setTitle("设置", forState: .Normal)
            }
            btn.addTarget(self, action: "HeadPropertyAction:", forControlEvents: UIControlEvents.TouchUpInside)
            addSubview(btn)
        }
    }
    
    
    func HeadPropertyAction(sender:UIButton){
    
        print("head..Property..")
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
