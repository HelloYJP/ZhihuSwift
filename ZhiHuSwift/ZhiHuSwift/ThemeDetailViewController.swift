//
//  ThemeDetailViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import SVProgressHUD

class ThemeDetailViewController: UIViewController {
    
    var themeModel:HomeDetailModel = HomeDetailModel() //和首页详情一样相同的处理
    var webView:UIWebView!
    var themeDetailId:Int?{
        
        didSet{
            
            weak var weakSelf = self
            
            themeModel.loadHomeDetailData(themeDetailId!) { () -> Void in
                weakSelf?.webView.loadHTMLString((weakSelf?.themeModel.loadHtmlForWebView())!, baseURL: nil)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
        
        SVProgressHUD.dismiss()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "主题详情"
        
        configUI()
    }

    func configUI(){
        
        let webView = UIWebView(frame: CGRect(x: 0, y: -20, width: ScreenWidth, height: ScreenHieght - 49 + 20))
        view.addSubview(webView)
        self.webView = webView
        
        
        let tabbar = HomeDetailTabBar(frame: CGRect(x: 0, y: ScreenHieght-49, width: ScreenWidth, height: 49))
        tabbar.delegate = self
        view.addSubview(tabbar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    deinit{
    
        print("主题内容销毁")
    }
}

extension ThemeDetailViewController:HomeDetailTabBarDelegate{
    
    func detailBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func detailNext() {
        
    }
    
    func detailVote() {
        
    }
    
    func detailShare() {
        
    }
    
    func detailComment() {
        
    }
}
