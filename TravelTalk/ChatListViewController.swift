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

    let chatList: [ChatRoom] = dummyChatList
    
    @IBOutlet var tableView: UITableView!

    var isFiltering: Bool = false
    var filteredList: [ChatRoom] = []
    var searchController: UISearchController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationAppearance("TRAVEL TALK")

        setSearchBar()
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
        tableView.showsVerticalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredList.count : chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chatRoom = isFiltering ? filteredList[indexPath.row] : chatList[indexPath.row]
        
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

extension ChatListViewController: UISearchResultsUpdating {
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func checkFiltering() -> Bool {
        return searchController.isActive && searchBarIsEmpty()
    }

    func setSearchBar() {
        searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self // 얘는 Delegate 대신 이걸 쓰는건가?
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.isActive = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterFriendsForSearchText(searchController.searchBar.text!)
    }
    
    func filterFriendsForSearchText(_ searchText: String, scope: String = "All") {
        let trimmedText = searchText.trimmingCharacters(in: [" "])
        if trimmedText.isEmpty {
            isFiltering = false
            filteredList = []
        } else {
            isFiltering = true
            filteredList = chatList.filter {
                $0.chatroomName.localizedCaseInsensitiveContains(trimmedText) ||
                $0.chatroomImage.contains(where: { $0.localizedCaseInsensitiveContains(trimmedText)})
            }
        }
        tableView.reloadData()
    }
}
