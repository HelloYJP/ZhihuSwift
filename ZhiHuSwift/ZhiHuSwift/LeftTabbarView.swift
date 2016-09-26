//
//  LeftTabbarView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/12.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class LeftTabbarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = LeftVCBackgroundColor
        
        configUI()
    }
    
    
    func configUI(){
    
        
        let width:CGFloat = 100.0
        for index in 0..<2{
        
            let btn = UIButton(frame: CGRect(x: width*CGFloat(index), y: 0, width: width, height: 49))
            btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            if index == 0 {
                btn.setImage(UIImage(named: "download"), forState: .Normal)
                btn.setTitle("  离线", forState: .Normal)
            }
            else
            {
                btn.setImage(UIImage(named: "leftNight"), forState: .Normal)
                btn.setTitle("  夜间", forState: .Normal)
            }
        
            addSubview(btn)
        }
    
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
