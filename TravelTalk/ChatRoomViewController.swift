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
    let textViewPlaceHolder = "메세지를 입력하세요"
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint! // 결국 사용 못함
    
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
//        textView.resignFirstResponder()
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let chatFromMeXib = UINib(nibName: ChatFromMeTableViewCell.identifier, bundle: nil)
        let chatFromFriendXib = UINib(nibName: ChatFromFriendTableViewCell.identifier, bundle: nil)
        let dateXib = UINib(nibName: DateTableViewCell.identifier, bundle: nil)
        tableView.register(chatFromMeXib, forCellReuseIdentifier: ChatFromMeTableViewCell.identifier)
        tableView.register(chatFromFriendXib, forCellReuseIdentifier: ChatFromFriendTableViewCell.identifier)
        tableView.register(dateXib, forCellReuseIdentifier: DateTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom.chatList.count
        //        return chatRoom.chatList.count+getRowForDate()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentChat = chatRoom.chatList[indexPath.row]
        let currentChatDate = DateFormatter.yyyyMMddHHmmFormatter.date(from: currentChat.date)
        
        //        if !isSameDate(indexPath) {
        //            print("! indexPath \(indexPath) \(currentChatDate)")
        //            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
        //            cell.configureData(currentChatDate!)
        //            chatRoom.chatList.insert(Chat(friend: .user, date: "", message: ""), at: indexPath.row)
        //            return cell
        //        } else {
        
        if currentChat.friend == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromMeTableViewCell.identifier, for: indexPath) as! ChatFromMeTableViewCell
            
            cell.configureData(currentChat)
            cell.tag = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatFromFriendTableViewCell.identifier, for: indexPath) as! ChatFromFriendTableViewCell
            
            cell.configureData(currentChat)
            cell.tag = indexPath.row
            
            return cell
        }
        
        //        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // [고민한 부분]
    // 날짜 변경 선을 넣어주기 위해서
    // 1. 현재 row 와 다음 row 간 날짜를 비교
    // 2. 날짜가 다르면 Date 표시용 cell 을 추가
    // 3. 아니라면 기존 채팅 Cell 추가
    // 4. row 갯수 반환할때 날짜용 Cell 이 필요한 만큼 계산해서 추가
    // 5. 그런데 cellForRowAt 에서 Index out of range 가 발생 -> 여기가 원인을 모르겠다
    //
    //    func isSameDate(_ indexPath: IndexPath) -> Bool {
    //        var result = false
    //
    //        if indexPath.row != 0 {
    //            let previousChat = chatRoom.chatList[indexPath.row - 1]
    //            let currentChat = chatRoom.chatList[indexPath.row]
    //            let previousChatDate = DateFormatter.yyMMddFormatter.date(from: previousChat.date)
    //            let currentChatDate = DateFormatter.yyMMddFormatter.date(from: currentChat.date)
    //            result = previousChatDate == currentChatDate
    //        }
    //
    //        return result
    //    }
    
    //    func getRowForDate() -> Int {
    //        var count = 0
    //
    //        for index in 0..<chatRoom.chatList.count-1 {
    //            let currentChatDate = DateFormatter.convertToyyMMdd(chatRoom.chatList[index].date)
    //            let nextChatDate = DateFormatter.convertToyyMMdd(chatRoom.chatList[index+1].date)
    //            if currentChatDate != nextChatDate {
    //                count += 1
    //            }
    //        }
    //        return count
    //    }
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
        
//        textView.inputAccessoryView = chatInputView // 텍스트뷰와 키보드를 연결
        // [고민한 부분]
        // inputAccessoryView 로 넣었더니 view.endEditing(true) 등 기존 뷰 관련한 내용들이 아무것도 동작하지 않음
        
        sendButton.setTitle("", for: .normal)
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.contentMode = .scaleAspectFit
        sendButton.tintColor = .black
        sendButton.isEnabled = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
            sendButton.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(#function)
        
    // [고민한 부분]
    // 텍스트뷰에 입력값이 있을 때마다 콘텐츠사이즈를 계산해서 텍스트뷰의 높이를 조절해주고자 함
    // 1. textView 의 사이즈에 intrinsicContentSize 를 추가했지만 적용안됨
    //    textView.sizeThatFits(textView.intrinsicContentSize)
    // 2. textView 의 constraint 를 Outlet 으로 추가해서 contentSize 를 넣었지만 적용안됨
    //    textViewHeightConstraint.constant = textView.contentSize.height
    // 3. 레이아웃을 다시 그려주는 layoutIfNeeded 를 추가히도 적용안됨
    //    textView.layoutIfNeeded()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            sendButton.isEnabled = false
        } else {
            sendButtonTapped(sendButton)
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        print(#function)
        let newDate: String = DateFormatter.yyyyMMddHHmmFormatter.string(from: Date())
        let newChat: Chat = Chat(friend: .user, date: newDate, message: textView.text)
        chatRoom.chatList.append(newChat)
        tableView.reloadData()
        scrollToBottom()
        textView.text = textViewPlaceHolder
        textView.textColor = .lightGray
        sendButton.isEnabled = false
//        textView.resignFirstResponder()
        view.endEditing(true)
    }
}

// https://ios-development.tistory.com/689 참고 블로그... 왜 내 코드에서는 작동 안할까?
