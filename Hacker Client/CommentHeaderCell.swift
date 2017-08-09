//
//  CommentHeaderCell.swift
//  Hacker Client
//
//  Created by Admin on 8/6/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

class CommentHeaderCell: UITableViewCell {

    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberOFCommentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
