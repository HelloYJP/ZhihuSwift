//
//  BaseViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import MMDrawerController

class BaseViewController: MMDrawerController {
    
    
    var leftController:LeftViewController = LeftViewController()
    var homeNavController:UINavigationController = BaseNavigationController(rootViewController: HomeTableViewController())
    var themeNavController:UINavigationController = BaseNavigationController(rootViewController: ThemeViewController())
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configDrawer()
    }
    
    
    func configDrawer(){
    
        maximumLeftDrawerWidth = LeftViewWidth
    
        
        openDrawerGestureModeMask = .All
        closeDrawerGestureModeMask = .All
        
        leftDrawerViewController = leftController
        centerViewController = homeNavController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
