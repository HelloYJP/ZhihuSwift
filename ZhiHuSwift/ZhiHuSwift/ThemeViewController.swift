//
//  ThemeViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/12.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import SDWebImage

class ThemeViewController: UIViewController,ThemeNavViewDelegate,UITableViewDataSource,UITableViewDelegate{
    
    var navView:ThemeNavView!
    var themeModel:ThemeModel = ThemeModel()
    var tableView:UITableView!
    var editorView:ThemeEditorView!
    
    var themeId:Int?{
    
        didSet{
            print(themeId)
            
            weak var weakSelf = self
            themeModel.loadThemeData(themeId!) { () -> Void in
                
                
                weakSelf?.editorView.editors = weakSelf?.themeModel.themeEditors

                weakSelf?.navView.imgView.sd_setImageWithURL(NSURL(string: weakSelf!.themeModel.background!), placeholderImage: UIImage(named: "placeholder.png"), completed: { (_, _, _, _) -> Void in
                })
                weakSelf!.tableView.reloadData()
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = true
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        configUI()
    }
    
    func configUI(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHieght-64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.registerNib(UINib(nibName: String(ThemeNoPicCell), bundle: nil), forCellReuseIdentifier: "themeNoPicCell_id")
        tableView.registerNib(UINib(nibName: String(HomeCell), bundle: nil), forCellReuseIdentifier: "themePicCell_id")
        view.addSubview(tableView)
        
        
        editorView = ThemeEditorView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        tableView.tableHeaderView = editorView
        
        navView = ThemeNavView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        navView.delegate = self
        view.addSubview(navView)
    }
    
    
    func backMenu() {
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! BaseViewController
        rootVC.toggleDrawerSide(.Left, animated: true, completion: nil)
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        let offY = scrollView.contentOffset.y
        
        if offY < 0 {
            var rect = navView?.frame
            rect?.size.height = 64 - offY
            rect?.origin.y = 0
            navView?.scrollView!.frame = rect!
        }

                
        if offY <= -120{
            tableView.contentOffset = CGPointMake(0, -120)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ThemeViewController {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return themeModel.numberOfRowsInSection()
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let themeStory = themeModel.themeStoryAtIndesPath(indexPath)
        
        if themeStory.images?.first == ""{ //没有图片
        
           let cell = tableView.dequeueReusableCellWithIdentifier("themeNoPicCell_id", forIndexPath: indexPath) as!ThemeNoPicCell
            cell.themeTitle.text = themeStory.title
            return cell
        }
        else{   //有图片
            let cell =  tableView.dequeueReusableCellWithIdentifier("themePicCell_id", forIndexPath: indexPath) as! HomeCell
            cell.titleContent.text = themeStory.title
            cell.imgView.sd_setImageWithURL(NSURL(string: (themeStory.images?.first)!), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let themeStory = themeModel.themeStoryAtIndesPath(indexPath)        
        let themeDetailVC = ThemeDetailViewController()
        themeDetailVC.themeDetailId = themeStory.id
        navigationController?.pushViewController(themeDetailVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

