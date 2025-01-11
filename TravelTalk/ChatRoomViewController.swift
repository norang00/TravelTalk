//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var tableView: UITableView!
    
    var chatRoom: ChatRoom = dummyChatList[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#function)
        
        setNavigationAppearance(chatRoom.chatroomName)
        setTableView()
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let chatFromMeXib = UINib(nibName: ChatFromMeTableViewCell.identifier, bundle: nil)
        let chatFromFriendXib = UINib(nibName: ChatFromFriendTableViewCell.identifier, bundle: nil)
        tableView.register(chatFromMeXib, forCellReuseIdentifier: ChatFromMeTableViewCell.identifier)
        tableView.register(chatFromFriendXib, forCellReuseIdentifier: ChatFromFriendTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        print(#function)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return chatRoom.chatList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatRoom.chatList[indexPath.row]
        
        if chat.friend == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromMeTableViewCell.identifier, for: indexPath) as! ChatFromMeTableViewCell
            
            cell.configureData(chat)
            cell.tag = indexPath.row
            print(#function, cell)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromFriendTableViewCell.identifier, for: indexPath) as! ChatFromFriendTableViewCell

            cell.configureData(chat)
            print(#function, cell)

            cell.tag = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
