//
//  ChatListItemTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatListItemTableViewCell: UITableViewCell {
    
    @IBOutlet var itemBackgroundView: UIView!
    @IBOutlet var friendProfileImageView: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendLatestChatLabel: UILabel!
    @IBOutlet var friendLatestDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
