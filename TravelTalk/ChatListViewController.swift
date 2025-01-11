//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by Kyuhee hong on 1/10/25.
//

import UIKit

class ChatListViewController: UIViewController {
    
    let chatList: [ChatRoom] = dummyChatList

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        
        setTableView()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let selectedCell = sender as! UITableViewCell
        let identifier = selectedCell.reuseIdentifier
//        
//        if let destination = segue.destination as! ChatRoomViewController {
//            destination.chat = 
//            
//        } else {
//            
//        }
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
        
        let rowData = chatList[indexPath.row]
        
        if rowData.chatroomImage.count == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as! ListItemTableViewCell
            cell.configureData(rowData)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemTableViewCell.identifier, for: indexPath) as! GroupItemTableViewCell
            cell.configureData(rowData)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
