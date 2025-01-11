//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatListViewController: UIViewController {

    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var tableView: UITableView!
    
    let chatList: [ChatRoom] = dummyChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        
        setTableView()

    }

}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let listItemXib = UINib(nibName: ListItemTableViewCell.identifier, bundle: nil)
        let groupItemXib = UINib(nibName: GroupItemTableViewCell.identifier, bundle: nil)
        tableView.register(listItemXib, forCellReuseIdentifier: ListItemTableViewCell.identifier)
        tableView.register(groupItemXib, forCellReuseIdentifier: GroupItemTableViewCell.identifier)
        
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chatRoom = chatList[indexPath.row]
        
        if chatRoom.chatroomImage.count == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as! ListItemTableViewCell
            cell.configureData(chatRoom)
            cell.tag = chatRoom.chatroomId
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemTableViewCell.identifier, for: indexPath) as! GroupItemTableViewCell
            cell.configureData(chatRoom)
            cell.tag = chatRoom.chatroomId
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = chatList[indexPath.row]
        if let vc = storyboard?.instantiateViewController(withIdentifier: ChatRoomViewController.identifier) as? ChatRoomViewController {
            vc.chatRoom = item
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
