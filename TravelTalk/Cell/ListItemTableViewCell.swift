//
//  ChatListItemTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet var itemBackgroundView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var latestChatLabel: UILabel!
    @IBOutlet var latestDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 25
        profileImageView.layer.backgroundColor = UIColor.white.cgColor

        nameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        latestChatLabel.font = .systemFont(ofSize: 12, weight: .medium)
        latestChatLabel.textColor = .darkGray
        latestChatLabel.textAlignment = .left
        latestChatLabel.contentMode = .top
        latestChatLabel.numberOfLines = 0

        latestDateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        latestDateLabel.textColor = .lightGray
        latestDateLabel.textAlignment = .right
        latestDateLabel.numberOfLines = 1
    }
    
    func configureData(_ chatRoom: ChatRoom) {        
        profileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
        nameLabel.text = chatRoom.chatroomName

        let lastChat = chatRoom.chatList.last
        latestChatLabel.text = lastChat?.message
        
        let lastDate = DateFormatter.convertToyyMMdd(lastChat?.date ?? "")
        latestDateLabel.text = lastDate
    }
    
}
