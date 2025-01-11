//
//  ChatFromFriendTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatFromFriendTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var talkBubbleView: UIView!
    @IBOutlet var talkBubbleImageView: UIImageView!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
        print(#function, "from friend")
    }
    
    func configure() {
        
        profileImageView.layer.cornerRadius = 25
        profileImageView.contentMode = .scaleAspectFit

        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        chatLabel.font = .systemFont(ofSize: 14, weight: .medium)
        chatLabel.textColor = .black
        chatLabel.textAlignment = .left
        chatLabel.contentMode = .top
        chatLabel.numberOfLines = 0

        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 1
    }
    
    func configureData(_ chat: Chat) {
        talkBubbleImageView.image = UIImage.talkbubble
        talkBubbleImageView.contentMode = .scaleToFill

        profileImageView.image = UIImage(named: chat.friend.profileImage)

        nameLabel.text = chat.friend.rawValue
        chatLabel.text = chat.message
        dateLabel.text = DateFormatter.convertToHHmm(chat.date)
    }
}
