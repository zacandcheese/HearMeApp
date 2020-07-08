//
//  CommentTableViewCell.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/29/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(comment: Comment){
        self.username.text = comment.userName
        self.comment.text = comment.comment
    }
}
