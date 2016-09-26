//
//  ContainViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/8.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class ContainViewController: UIViewController {
    
    var drawerState:Bool = false
    
    
    var leftController:UIViewController?{
        
        didSet{
            view.addSubview((leftController?.view)!)
            addChildViewController(leftController!)
        }
    }
    var centerContrller:UIViewController?{
    
        didSet{
            
            if childViewControllers.count > 1
            {
                childViewControllers.last?.view.removeFromSuperview()
                childViewControllers.last?.removeFromParentViewController()
            }
            
            view.addSubview((centerContrller?.view)!)
            addChildViewController(centerContrller!)
        }
    }
    
    
    var controllers:[UIViewController]?{
        
        didSet{
            
            self.leftController = controllers![0]
            self.centerContrller = controllers![1]
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - 打开与关闭
    func openDrawer(){
        
        weak var weakSelf = self
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
            weakSelf!.centerContrller?.view.frame = CGRect(x: 200, y: 0, width: ScreenWidth, height: ScreenHieght)
        }
        drawerState = true
    }
    
    
    func closeDrawer(){
        weak var weakSelf = self
        
        UIView.animateWithDuration(0.3) { () -> Void in
    
           weakSelf!.centerContrller?.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHieght)
        }
        drawerState = false
    }
    
    
    func toggleDrawer(){
                
        if drawerState  //当前正开着
        {
            closeDrawer()
        }
        else    //当前正关着
        {
            openDrawer()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
