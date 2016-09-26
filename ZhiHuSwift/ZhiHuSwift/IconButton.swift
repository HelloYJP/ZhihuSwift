//
//  IconButton.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/9.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class IconButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView?.layer.cornerRadius = 18
        imageView?.clipsToBounds = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        return CGRect(x: 50, y: 0, width: 120, height: 36)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        return CGRect(x: 0, y: 0, width: 36, height: 36)
    }
    
}
