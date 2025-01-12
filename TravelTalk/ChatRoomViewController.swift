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
    
    @IBOutlet var chatInputView: UIView!
    @IBOutlet var inputBackgroundView: UIView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!
//    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    
    var chatRoom: ChatRoom = dummyChatList[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationAppearance(chatRoom.chatroomName)
        setTableView()
        setTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
 
    func scrollToBottom() {
        tableView.scrollToRow(at: IndexPath(row: chatRoom.chatList.count-1, section: 0), at: .bottom, animated: false)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatRoom.chatList[indexPath.row]

        if chat.friend == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromMeTableViewCell.identifier, for: indexPath) as! ChatFromMeTableViewCell

            cell.configureData(chat)
            cell.tag = indexPath.row

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromFriendTableViewCell.identifier, for: indexPath) as! ChatFromFriendTableViewCell

            cell.configureData(chat)
            cell.tag = indexPath.row

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ChatRoomViewController: UITextViewDelegate {
    
    func setTextView() {
        textView.delegate = self

        inputBackgroundView.layer.cornerRadius = 8
        inputBackgroundView.layer.backgroundColor = UIColor.textViewBackground.cgColor
        
        textView.text = "메세지를 입력하세요"
        textView.textColor = .gray
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.borderStyle = .none
        textView.backgroundColor = .clear
        
        textView.isEditable = true
        
        textView.inputAccessoryView = chatInputView
        
        sendButton.setTitle("", for: .normal)
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.contentMode = .scaleAspectFit
        sendButton.tintColor = .black
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == "메세지를 입력하세요" {
                textView.text = ""
                textView.textColor = .black
            }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(#function)
        print("\(textView.text)")
        
//        textView.sizeThatFits(textView.intrinsicContentSize)
//        textViewHeightConstraint.constant = textView.contentSize.height
        // 텍스트뷰 세줄까지 늘려보기 절대 안됨 아무리해도 안바뀜... 왜지?
        // 1. intrinsicContentSize 추가해도 안됨
        // 2. Constraint 를 outlet 으로 빼도 안됨
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty {
                textView.text = "메세지를 입력하세요"
                textView.textColor = .gray
            }
        
        let newDate: String = DateFormatter.yyyyMMddHHmmFormatter.string(from: Date())
        let newChat: Chat = Chat(friend: .user, date: newDate, message: textView.text)
        chatRoom.chatList.append(newChat)
        textView.text = ""
        
        print("newChat \(newChat)")
        print(chatRoom.chatList)
        
        tableView.reloadData()
        scrollToBottom()
    }

    
}
