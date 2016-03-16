//
//  GithubRepoCell.swift
//  GithubDemo
//
//  Created by Liem Ly Quan on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class GithubRepoCell: UITableViewCell {
  @IBOutlet weak var repoNameLabel: UILabel!
  @IBOutlet weak var ownerNameLabel: UILabel!
  @IBOutlet weak var starCountLabel: UILabel!
  @IBOutlet weak var forkCountLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
