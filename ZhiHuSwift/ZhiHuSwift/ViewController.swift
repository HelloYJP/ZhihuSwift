//
//  ViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/8/23.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    var scrollView:UIScrollView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "nextAction")
        
    }
    
    
    func nextAction()
    {
        navigationController?.pushViewController(HomeTableViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

