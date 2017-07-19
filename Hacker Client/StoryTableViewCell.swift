//
//  StoryTableViewCell.swift
//  Hacker Client
//
//  Created by Admin on 7/8/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var urlLabel: UILabel!
    
    var tapComments: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func gotoComments(_ sender: UIButton) {
        tapComments?(self)
    }
}
