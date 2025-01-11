//
//  GroupChatItemTableViewCell.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class GroupItemTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageViews: [UIImageView]!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var latestChatLabel: UILabel!
    @IBOutlet var latestDateLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
        for item in profileImageViews {
            item.contentMode = .scaleAspectFit
            item.layer.cornerRadius = 23/2
        }
        
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
        
        for (index, item) in profileImageViews.enumerated() {
            item.image = UIImage(named: chatRoom.chatroomImage[index])
        }
        /* [고민되는 부분]
         1. 보통 리스트 셀에 나타나는 프로필 사진 구성은 1,2,3,4 네가지 케이스만 있으니까 셀을 따로 만드는게 나은가?
         리스트 셀의 프로필사진 부분만 갈아끼우는 것은 안되나?
         2. listItemTableViewCell 이랑 코드도 거의 똑같은데 합칠 수 없나?
         */
        
        nameLabel.text = chatRoom.chatroomName
        
        let lastChat = chatRoom.chatList.last
        latestChatLabel.text = lastChat?.message

        let lastDate = DateFormatter.convertToyyMMdd(lastChat?.date ?? "")
        latestDateLabel.text = lastDate
    }
}
