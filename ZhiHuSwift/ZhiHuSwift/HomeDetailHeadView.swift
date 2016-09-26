//
//  HomeDetailHeadView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/19.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class HomeDetailHeadView: UIView {

    var scrollView:UIScrollView!
    var imgView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    
    func configUI()
    {
        let scrollView = UIScrollView(frame: self.bounds)
        addSubview(scrollView)
        self.scrollView = scrollView
        
        let imgView = UIImageView(frame: self.bounds)
        imgView.contentMode = .ScaleAspectFill
        imgView.autoresizingMask = .FlexibleHeight
        scrollView.addSubview(imgView)
        self.imgView = imgView
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
