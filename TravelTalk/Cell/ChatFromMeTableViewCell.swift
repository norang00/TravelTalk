//
//  ChatFromMeTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatFromMeTableViewCell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
    
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
        talkBubbleImageView.image = UIImage.mytalkbubble
        talkBubbleImageView.contentMode = .scaleToFill
        
        chatLabel.font = .systemFont(ofSize: 12, weight: .medium)
        chatLabel.textColor = .black
        chatLabel.textAlignment = .left
        chatLabel.contentMode = .top
        chatLabel.numberOfLines = 0

        dateLabel.font = .systemFont(ofSize: 8, weight: .medium)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .right
        dateLabel.numberOfLines = 1
    }
    
    func configureData(_ chat: Chat) {
        chatLabel.text = chat.message
        dateLabel.text = DateFormatter.convertToHHmm(chat.date)
    }
}
