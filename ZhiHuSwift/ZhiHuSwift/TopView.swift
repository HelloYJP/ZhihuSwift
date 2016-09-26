//
//  TopView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/8/29.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class TopView: UIView ,UIScrollViewDelegate{

    let width = UIScreen.mainScreen().bounds.width
    
    var topScrollView:UIScrollView?
    
    var pageController:UIPageControl?
    var imageTitle:[String]?
    var imagesUrl:[String]?{
    
        didSet{
            
            topScrollView?.contentSize = CGSizeMake(width * CGFloat((imagesUrl?.count)!), 200)
            topScrollView?.showsHorizontalScrollIndicator = false
        }
    }
    
    
    var imageNum:Int = 1{
        
        didSet{
            
            pageController?.numberOfPages = imageNum
            
            for i in 0..<imageNum{
                let imgView = UIImageView(frame: CGRectMake(width * CGFloat(i), 0, width, 200))
                imgView.contentMode = UIViewContentMode.ScaleAspectFill
                let urlStr = imagesUrl![i]
                imgView.sd_setImageWithURL(NSURL(string: urlStr), placeholderImage: UIImage(named: "placeholder.png"))
                imgView.autoresizingMask = .FlexibleHeight
                topScrollView?.addSubview(imgView)
                
                
                let title = UILabel(frame: CGRect(x: width*CGFloat(i)+10, y: 130, width: ScreenWidth - 20, height: 50))
                title.textColor = UIColor.whiteColor()
                title.autoresizingMask = .FlexibleTopMargin
                title.text = imageTitle![i]
                title.numberOfLines = 0
                title.font = UIFont.boldSystemFontOfSize(20)
                topScrollView?.addSubview(title)
                
                }
            }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        configUI()
        
        self.imagesUrl = [String]()
    }
    
    func configUI(){
                
        topScrollView = UIScrollView()
        topScrollView?.showsVerticalScrollIndicator = false
        topScrollView?.showsHorizontalScrollIndicator = false
        topScrollView?.frame = CGRectMake(0, 0, width, 200)
        topScrollView?.pagingEnabled = true
        topScrollView?.delegate = self
        addSubview(topScrollView!)
        
        
        let pageController = UIPageControl(frame: CGRect(x: 0, y: 180, width: ScreenWidth, height: 20))
        addSubview(pageController)
        self.pageController = pageController
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageNum = scrollView.contentOffset.x / ScreenWidth
        pageController?.currentPage = Int(pageNum)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
