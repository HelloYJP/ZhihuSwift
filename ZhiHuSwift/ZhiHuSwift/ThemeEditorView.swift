//
//  ThemeEditorView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/20.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class ThemeEditorView: UIView {
    
    
    var editors:[ThemeEditor]?{
        
        willSet{
        
            for subView in self.subviews
            {
                if subView.isMemberOfClass(UIImageView.self){
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet{
        
            for index in 0..<editors!.count{
                
                let editor = editors![index]
                
                let avatar = UIImageView(frame: CGRect(x: 50 + 30 * CGFloat(index), y: 7, width: 26, height: 26))
                avatar.layer.cornerRadius = 13
                avatar.clipsToBounds = true
                avatar.sd_setImageWithURL(NSURL(string: editor.avatar!), placeholderImage: UIImage(named: "placeholder.png"))
                addSubview(avatar)
    
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    func configUI(){
    
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: 40, height: 40))
        title.textAlignment = .Center
        title.textColor = UIColor.grayColor()
        title.font = UIFont.systemFontOfSize(15)
        title.text = "主编"
        addSubview(title)
        
        let line = UIView(frame: CGRect(x: 0, y: 39, width: ScreenWidth, height: 0.5))
        line.backgroundColor = UIColor.grayColor()
        addSubview(line)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
