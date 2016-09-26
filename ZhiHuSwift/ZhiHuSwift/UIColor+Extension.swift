//
//  UIColor+Extension.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/9.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

extension UIColor{

    
    class func colorWithRGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    //默认的蓝色，更改透明度
    class func colorWithAlpha(alpha:CGFloat) ->UIColor{
        return UIColor(red: 41 / 255.0, green: 169 / 255.0, blue: 245 / 255.0, alpha: alpha)
    }
    

}