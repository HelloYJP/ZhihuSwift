//
//  HomeCell.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/8/24.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var titleContent: UILabel!

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
