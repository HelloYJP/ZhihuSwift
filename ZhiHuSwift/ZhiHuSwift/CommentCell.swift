//
//  CommentCell.swift
//  ZhiHuSwift
//
//  Created by YangJingping on 16/9/22.
//  Copyright © 2016年 YJP. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var avatorImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCommentCell(comment:ShortComment){
    
        avatorImg.sd_setImageWithURL(NSURL(string: comment.avatar!), placeholderImage: UIImage(named: "placeholder.png"))
        avatorImg.clipsToBounds = true
        avatorImg.layer.cornerRadius = 15
        
        name.text = comment.author!
        content.text = comment.content!
        likeBtn.setTitle(" "+String(comment.likes), forState: .Normal)
    }
    
    
    func configCommentTime(time:String){
        self.time.text = time
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
