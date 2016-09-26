//
//  SectionView.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/12.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class SectionView: UITableViewHeaderFooterView {

    var titleLabel:UILabel?
    
     override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = HomeSegementBlue
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
