//
//  LeftViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/8.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var tableView:UITableView!
    let cellIdentifier = "leftCell"
    var headView:LeftHeadView!
    var leftModel:LeftModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        configUI()
        
        //
        fetchThemeData()
        
        // Do any additional setup after loading the view.
    }
    
    func configUI(){
        
        headView = LeftHeadView(frame: CGRect(x: 0, y: 0, width: LeftViewWidth, height: 110))
        headView.backgroundColor = LeftVCBackgroundColor
        view.addSubview(headView)
        
    
        tableView = UITableView(frame: CGRect(x: 0, y: 110, width: LeftViewWidth, height: ScreenHieght-110-49), style: UITableViewStyle.Plain)
        tableView.backgroundColor = LeftVCBackgroundColor
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        
        
        let tabbar = LeftTabbarView(frame: CGRect(x: 0, y: ScreenHieght-49, width: LeftViewWidth, height: 49))
        view.addSubview(tabbar)
        
    }
    
    
    func fetchThemeData(){
    
        LeftModel.loadThemesData { (leftModel) -> Void in
            
            self.leftModel = leftModel
            self.tableView.reloadData()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LeftViewController{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return  self.leftModel?.others.count ?? 0
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.textColor = UIColor.lightGrayColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        
        if indexPath.section == 0{
            cell.textLabel?.text = "首页"
        }
        else{
            cell.textLabel?.text = self.leftModel?.others[indexPath.row].name
        }
        
        cell.backgroundColor = LeftVCBackgroundColor
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! BaseViewController
        
        
        if indexPath.section == 1{ //主题
            
            let themeVC = rootVC.themeNavController.viewControllers.first as! ThemeViewController
            let model = leftModel?.others[indexPath.row]
            themeVC.themeId = model!.id
            rootVC.setCenterViewController(rootVC.themeNavController, withCloseAnimation: true, completion: nil)
            
        }
        else //首页
        {
            
            rootVC.setCenterViewController(rootVC.homeNavController, withCloseAnimation: true, completion: nil)
        }
    }
}

