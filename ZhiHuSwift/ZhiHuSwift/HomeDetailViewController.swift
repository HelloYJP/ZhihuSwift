//
//  HomeDetailViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/18.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeDetailViewController: UIViewController,UIScrollViewDelegate {
    
    var webView:UIWebView!
    var headView:HomeDetailHeadView!
    var containView:UIView!
    var homeDetailModel:HomeDetailModel = HomeDetailModel()
    var tabbar:HomeDetailTabBar!
    var homeModel:HomeModel?
    var isLoading:Bool = false
    var detailId:Int?{
    
        didSet{
            
            weak var weakSelf = self
            
            loadData(detailId!) { () -> Void in
                
                weakSelf!.containView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHieght)
                weakSelf?.isLoading = false
            }
            
            
            weakSelf?.homeDetailModel.loadHomeDetailExtraData(detailId!, completion: { () -> Void in
                
                weakSelf?.tabbar.setPopularityAndComments((weakSelf?.homeDetailModel.popularity)!, Comments: (weakSelf?.homeDetailModel.comments)!)
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.whiteColor()
        
        configUI()
    }
    
    //MARK: - 配置视图
    func configUI(){
        
        
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHieght))
        view.addSubview(containView)
        self.containView = containView
        
        
        let webView = UIWebView(frame: CGRect(x: 0, y: -20, width: ScreenWidth, height: ScreenHieght-49 + 21))
        webView.scrollView.delegate = self
        webView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        webView.backgroundColor = UIColor.whiteColor()
        containView.addSubview(webView)
        self.webView = webView
        
        
        let headView = HomeDetailHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 215))
        self.headView = headView
        webView.scrollView.addSubview(headView)
        
        let tabbar = HomeDetailTabBar(frame: CGRect(x: 0, y: ScreenHieght-49, width: ScreenWidth, height: 49))
        tabbar.delegate = self
        view.addSubview(tabbar)
        self.tabbar = tabbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - 加载数据
    func loadData(detailId:Int,completion:()->Void){
    
        weak var weakSelf = self
        homeDetailModel.loadHomeDetailData(detailId) { () -> Void in
            
            weakSelf?.headView.imgView.sd_setImageWithURL(NSURL(string: (weakSelf?.homeDetailModel.detailModel?.image)!), placeholderImage: UIImage(named: "placeholder.png"))
            
            weakSelf?.webView.loadHTMLString((weakSelf?.homeDetailModel.loadHtmlForWebView())!, baseURL: nil)
            
            completion()
        }
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offY = scrollView.contentOffset.y

        if offY < 0{
            var rect = headView?.frame
            rect?.size.height = 200 - offY
            rect?.origin.y = offY
            headView?.scrollView!.frame = rect!
        }
        
        
        if offY >= -100 && offY <= -70 && !scrollView.dragging{
            
            loadPreviousNews()
        }else if offY < -100 {
            self.webView.scrollView.contentOffset = CGPoint(x: 0, y: -100)
        }else if (offY + ScreenHieght) > (scrollView.contentSize.height+80) && !scrollView.dragging{
            
            loadNextNews()
        }
        
        if offY > 195{
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        }
        else{
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        }
        
    }
    
    //MARK: - 加载上一篇
    func loadPreviousNews(){
        
        let themeId = homeModel!.getPreviousNewsId(detailId!)
        
        if themeId == 0 {
            print("已经是第一篇了")
            return
        }
        
        if isLoading{
            return
        }
        
        print("加载上一篇")
        
        isLoading = true
        
        weak var weakSelf = self
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            weakSelf!.containView.frame = CGRect(x: 0, y: ScreenHieght, width: ScreenWidth, height: ScreenHieght)
            
            }) { (_) -> Void in
            
                weakSelf!.detailId = themeId
        }
    }
    
    //MARK: - 加载下一篇
    func loadNextNews(){
        
        let themeId = homeModel!.getNextNewsId(detailId!)
        
        if themeId == detailId! {
            print("当前加载的最大数加载")
            return
        }
        
        if isLoading{
            return
        }
        
        print("加载下一篇")
        
        isLoading = true
        
        weak var weakSelf = self
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            weakSelf!.containView.frame = CGRect(x: 0, y: -ScreenHieght, width: ScreenWidth, height: ScreenHieght)
            
            }) { (_) -> Void in
                
                weakSelf!.detailId = themeId
        }
    }
    
    
    
    deinit{
        print("销毁")
    }
}


//MARK: - Tarbar方法
extension HomeDetailViewController:HomeDetailTabBarDelegate{

    func detailBack() {
        
        SVProgressHUD.dismiss()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func detailNext() {
        loadNextNews()
    }

    func detailVote() {
        
    }

    func detailShare() {
        
    }
    
    func detailComment() {
        
        let commentVC = CommentViewController()
        commentVC.commemtId = detailId!
        commentVC.titleContent = homeDetailModel.comments
        navigationController?.pushViewController(commentVC, animated: true)
        
    }
}


