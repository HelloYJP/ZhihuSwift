//
//  HomeTableViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/8/24.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeTableViewController: UIViewController,UITableViewDelegate,NavViewDelegate,UITableViewDataSource {

    let SectionViewIdentifier = "sectionviewidentifier"
    var headView:TopView!
    var tableView:UITableView!
    var navView:NavView!
    var isloading:Bool = false
    var homeModel:HomeModel = HomeModel()
    
    var dataArray:[HomeModel]?{
        
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
                
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
    
    //MARK: - viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.sharedApplication().statusBarHidden = false
        navigationController?.navigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
        
        configTableView()
        fetchHomeData()
    }
    
    
    //MARK: - 配置tableView
    private func configTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHieght), style:.Plain)
        tableView.registerNib(UINib(nibName: String(HomeCell), bundle: nil), forCellReuseIdentifier: "cell_id")
        tableView.registerClass(SectionView.classForCoder(), forHeaderFooterViewReuseIdentifier: SectionViewIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)

        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
      
        headView = TopView(frame: CGRect(x: 0, y: 0, width:ScreenWidth, height: 200))
        tableView.tableHeaderView = headView
        
        
        navView = NavView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        navView.delegate = self
        view.addSubview(navView)
    }
    
    //MARK: - 获取数据
    func fetchHomeData(){
        
        weak var weakSelf = self
        
        homeModel.loadLastedHomeData { () -> Void in
            
            
            weakSelf?.headView.imageTitle = weakSelf?.homeModel.loopImageTitles()
            weakSelf?.headView?.imagesUrl = weakSelf?.homeModel.loopImagesUrls()
            weakSelf?.headView?.imageNum = (weakSelf?.homeModel.numberOfLoopImages())!
        
            weakSelf?.tableView.reloadData()
        }
    }
    
    
    //MARK: - 左侧菜单
    func leftMenu() {
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! BaseViewController
        rootVC.toggleDrawerSide(.Left, animated: true, completion: nil)
    }


    //MARK: - 刷新
    func headerRefresh(){
    
        isloading = true
        
        weak var weakSelf = self
        homeModel.loadLastedHomeData { () -> Void in
            
            weakSelf?.navView.indicator?.stopAnimating()
            weakSelf?.navView.indicator?.hidesWhenStopped = true
            weakSelf?.tableView.reloadData()
            weakSelf?.isloading = false
        }
    }
    
    func footerRefresh(){
        
        weak var weakSelf = self
        homeModel.loadPreviousHomeData { () -> Void in
            
            weakSelf?.tableView.reloadData()
            weakSelf?.tableView.mj_footer.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - Table view data source
extension HomeTableViewController{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return homeModel.numberOfSections()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModel.numberOfRowInSection(section) ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath) as! HomeCell
        
        let story = homeModel.storyAtIndexPath(indexPath)
        cell.titleContent.text = story.title
        cell.imgView.sd_setImageWithURL(NSURL(string: (story.images?.first)!), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
            return 0
        }
        else{
            return 40
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let secView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(SectionViewIdentifier) as! SectionView
        secView.titleLabel?.text = homeModel.dateStringOfSection(section)
        return secView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let story = homeModel.storyAtIndexPath(indexPath)
        let homeDetailVC = HomeDetailViewController()
        homeDetailVC.detailId = story.id
        homeDetailVC.homeModel = self.homeModel
        navigationController?.pushViewController(homeDetailVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    //MARK: - ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        
        if offY <= 0{
            var rect = headView?.frame
            rect?.size.height = 200 - offY
            rect?.origin.y = offY
            headView?.topScrollView!.frame = rect!
        }
        
        if offY >= -90.0{
        
            //circle的进度
            let loadPercent = offY/(-50.0)
            
            if !isloading {
                navView.loadProgress = (loadPercent > 1.0 ? 1.0:loadPercent)
            }
            else{
                navView.loadProgress = 0.0
            }
            
            
            if offY < -50.0 && offY >= -90.0 && !scrollView.dragging && !isloading{
                
                navView.loadProgress = 0.0
                navView.indicator?.hidden = false
                navView.indicator?.startAnimating()
                headerRefresh()
            }
        }
        
        
        if offY <= -90{
            tableView.contentOffset = CGPointMake(0, -90)
        }

        
        //透明度
        let percent = offY/200.0
        navView.statusView.backgroundColor = UIColor.colorWithAlpha(percent)
        navView.navigationView.backgroundColor = UIColor.colorWithAlpha(percent)
        
        //便宜设置
        if offY > 200.0{
            scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        }
        else{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        
        //标题
        if offY >= (80.0 * CGFloat(homeModel.numberOfRowInSection(0))+180.0){
            navView.navigationView.backgroundColor = UIColor.colorWithAlpha(0)
            navView.navTitle.text = ""
        }
        else{
            navView.navTitle.text = "今日热闻"
        }
    }
}


