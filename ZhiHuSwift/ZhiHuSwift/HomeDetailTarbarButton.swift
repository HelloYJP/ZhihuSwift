//
//  HomeDetailTarbarButton.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class HomeDetailTarbarButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.font = UIFont.systemFontOfSize(9)
        titleLabel?.textAlignment = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let titleX:CGFloat = (imageView?.frame.size.width)!-31
        let titleY:CGFloat =  11
        let titleWidth:CGFloat = 20.0
        let titleHeight:CGFloat = 10.0
        return CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
    }

//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        
//    }
}
