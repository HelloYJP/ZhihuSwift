//
//  BaseNavigationController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {

        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! BaseViewController
        
        if viewControllers.count > 1{
        
            rootVC.openDrawerGestureModeMask = .None
        }
        else{
            rootVC.openDrawerGestureModeMask = .All
        }
    }

}
