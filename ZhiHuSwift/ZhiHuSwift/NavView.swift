//
//  NavView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit


protocol NavViewDelegate{
    
    func leftMenu()

}

class NavView: UIView {
    
    var navTitle:UILabel!
    var navigationView:UIView!
    var statusView:UIView!
    var loadShaper:CAShapeLayer? //圆
    var indicator:UIActivityIndicatorView? //加载
    var loadProgress:CGFloat = 0.0{
        
        didSet{
            loadShaper?.strokeEnd = loadProgress
        }
    }
    
    var delegate:NavViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    func configUI(){
    
        self.backgroundColor = UIColor.colorWithAlpha(0)
    
        let statusView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        addSubview(statusView)
        self.statusView = statusView
        
        
        let navigationView = UIView(frame: CGRect(x: 0, y: 20, width: ScreenWidth, height: 44))
        addSubview(navigationView)
        self.navigationView = navigationView
        
        
        let leftBtn = UIButton(frame: CGRect(x: 10, y: 3, width: 35, height: 35))
        leftBtn.addTarget(self, action: "leftAction", forControlEvents: UIControlEvents.TouchUpInside)
        leftBtn.setImage(UIImage(named: "leftIcon"), forState: .Normal)
        navigationView.addSubview(leftBtn)
        
        
        let navTitle = UILabel(frame: CGRect(x: self.center.x-40, y: 0, width: 80, height: 44))
        navTitle.textAlignment = .Center
        navTitle.text = "今日热闻"
        navTitle.textColor = UIColor.whiteColor()
        navigationView.addSubview(navTitle)
        self.navTitle = navTitle
        
        
        let bezierpath = UIBezierPath(ovalInRect: CGRect(x: self.center.x-60, y: 32, width: 20, height: 20))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 1;
        shapeLayer.strokeEnd = 0
        shapeLayer.path = bezierpath.CGPath;
        layer.addSublayer(shapeLayer)
        self.loadShaper = shapeLayer
        
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: self.center.x-60, y: 32, width: 20, height: 20))
        addSubview(indicator)
        indicator.hidden = true
        self.indicator = indicator
    }
    
    func leftAction(){
        self.delegate?.leftMenu()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
