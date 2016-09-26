//
//  CommentViewController.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/21.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit
import SVProgressHUD

class CommentViewController: UIViewController {

    let cellIdentifier = "comment_id"
    var navView:CommentNavView!
    var commentModel:CommentModel = CommentModel()
    var tableView:UITableView!
    var titleContent:Int?
    
    var commemtId:Int?{
    
        didSet{
            
            weak var weakSelf = self
            
            commentModel.loadLongCommentData(commemtId!) { () -> Void in
//                weakSelf?.tableView.reloadData()
            }
            
            
            commentModel.loadShortCommentData(commemtId!) { () -> Void in
                weakSelf?.tableView.reloadData()
            }
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
        
        navView.titleLabel?.text = String(titleContent!) + "条点评"
    }
    
    
    func configUI(){
        
        let navView = CommentNavView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        view.addSubview(navView)
        self.navView = navView
    
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHieght - 64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: String(CommentCell), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CommentViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModel.numberRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CommentCell
        
        let shortComment = commentModel.commentAtIndexPath(indexPath)
        cell.configCommentCell(shortComment)
        cell.configCommentTime(commentModel.getStandardTime(shortComment.time))
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            if commentModel.numberRowsInSection(0) == 0{
            
                return "长评论（暂无）"
            }
            return "长评论"
        }
        return "短评论"
    }

}



