//
//  TweetTableTableViewCell.swift
//  Twitter
//
//  Created by Jay on 2022/10/1.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
