//
//  CommentNavView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/22.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class CommentNavView: UIView {

    var titleLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = HomeSegementBlue
        
        configUI()
        
    }
    
    
    func configUI(){
        
        let title = UILabel(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: 44))
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        addSubview(title)
        self.titleLabel = title
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
