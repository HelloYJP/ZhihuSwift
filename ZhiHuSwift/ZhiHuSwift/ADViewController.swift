//
//  ADViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/6.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class ADViewController: UIViewController {
    
    
    private var admodel:ADModel?
    
    lazy var backImgView:UIImageView = {
        
        let backImgView = UIImageView()
        backImgView.frame = ScreenBounds
        return backImgView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        
        view.addSubview(backImgView)
        
        weak var weakSelf = self
        
        ADModel.loadADData { (model, error) -> Void in
            
            print("数据：\(model)...错误：\(error)")
            
            if let ad = model{
            
                weakSelf!.admodel = ad
                [weakSelf?.setupBackgroundImage(true)];
                return
            }
            
            [weakSelf?.setupBackgroundImage(false)];
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setupBackgroundImage(result:Bool){
    
        
        if result
        {
            
            weak var weakSelf = self
            
            backImgView.sd_setImageWithURL(NSURL(string: (admodel?.img)!), placeholderImage: nil)
            backImgView.alpha = 1
            
            UIView.animateWithDuration(2, animations: { () -> Void in
                
                weakSelf?.backImgView.transform = CGAffineTransformMakeScale(1.5, 1.5)
                weakSelf?.backImgView.alpha = 0
                
                }, completion: { (_) -> Void in
                 NSNotificationCenter.defaultCenter().postNotificationName(ADFinished, object: nil)
            })
    
        }
        else
        {
            
            NSNotificationCenter.defaultCenter().postNotificationName(ADFinished, object: nil)
        
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
