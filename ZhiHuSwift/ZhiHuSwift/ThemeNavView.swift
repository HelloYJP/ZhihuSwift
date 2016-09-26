//
//  ThemeNavView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

protocol ThemeNavViewDelegate{

    func backMenu()

}


class ThemeNavView: UIView {
    
    var delegate:ThemeNavViewDelegate?
    var imgView:UIImageView!
    var scrollView:UIScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        
    }
    
    func configUI(){
        
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        addSubview(scrollView)
        self.scrollView = scrollView
        
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        imgView.contentMode = .ScaleAspectFill
        imgView.autoresizingMask = .FlexibleHeight
        scrollView.addSubview(imgView)
        self.imgView = imgView
        
    
        let backBtn = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 40))
        backBtn.setImage(UIImage(named: "detail_NavBack"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(backBtn)
        
        
        let navTitle = UILabel(frame: CGRect(x: self.center.x-50, y: 20, width: 100, height: 44))
        navTitle.text = "主题"
        navTitle.textAlignment = .Center
        navTitle.textColor = UIColor.whiteColor()
        addSubview(navTitle)
        
    }
    
    func backAction(){
    
        self.delegate?.backMenu()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
