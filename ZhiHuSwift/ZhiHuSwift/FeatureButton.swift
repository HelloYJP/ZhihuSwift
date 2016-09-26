//
//  FeatureButton.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class FeatureButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let imageX = 10
        let imageY = 0
        let imageWidth = 20
        let imageHeight = 20
        return CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleX = 10
        let titleY = 20
        let titleWidth = 20
        let titleHeight = 20
        return CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
    }
    
    
}
