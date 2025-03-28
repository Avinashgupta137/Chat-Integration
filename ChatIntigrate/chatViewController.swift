//
//  chatViewController.swift
//  Project
//
//  Created by Gunjan on 03/01/25.
//

import UIKit

class chatViewController: UIViewController {
    
    
    @IBOutlet weak var viwText: UIView!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var imgchat: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblNum: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    
    // MARK: - Properties
    var booking: Datas?
    var messages: [SendMessage] = []
    var requestId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        fetchMessages(requestId: requestId)
    }
    
    // MARK: - Setup
    func setupUI() {
        if let booking = booking {
            lblName.text = booking.customer?.name
            lblMail.text = booking.customer?.email
            lblNum.text = booking.customer?.mobile
            lblCode.text = booking.postal_code
            let imageUrlString = "https://mt.localserverpro.com/public/storage/\(booking.image ?? "")"
            if let url = URL(string: imageUrlString) {
                imgchat.loadImage(from: url)
            }
        }
        viwText.layer.borderWidth = 1.5
        viwText.layer.borderColor = UIColor.gray.cgColor
        viwText.layer.cornerRadius = 30
        chatTableView.separatorStyle = .none
        chatTableView.backgroundColor = UIColor.white
        chatTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func setupTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.tableFooterView = UIView()
    }
    
    // MARK: - API Calls
    func fetchMessages(requestId: String) {
        let endpoint = "/chat/detail/\(requestId)?page=\(1)&limit=\(100)"
        ApiClient.shared.callHttpMethod(
            apiendpoint: endpoint,
            method: .get,
            param: [:],
            model: MessagesResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.messages = data.map { SendMessage(from: $0) }
                    self?.chatTableView.reloadData()
                    DispatchQueue.main.async {
                        if let self = self, !self.messages.isEmpty {
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            if self.chatTableView.numberOfRows(inSection: 0) > indexPath.row {
                                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                            } else {
                                print("TableView is empty, cannot scroll")
                            }
                        }
                        
                    }
                } else {
                    print("No data received")
                }
            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func sendMessage(_ sender: UIButton) {
        guard let messageText = messageTextField.text, !messageText.isEmpty else {
            return
        }
        sendMessage(requestId: requestId , message : messageText)
    }
    
    func sendMessage(requestId: String, message: String) {
        let params: [String: Any] = [
            "request_id": requestId,
            "message": message,
            "type": "text"
        ]
        ApiClient.shared.callHttpMethod(
            apiendpoint: Constant.chatStore,
            method: .post,
            param: params,
            model: SendMessageResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let newMessages = response.data.first {
                        self.messages.append(newMessages)
                        self.chatTableView.reloadData()
                        
                        let lastRow = self.messages.count - 1
                        if lastRow >= 0, self.chatTableView.numberOfRows(inSection: 0) > lastRow {
                            let indexPath = IndexPath(row: lastRow, section: 0)
                            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        }
                    }
                    
                    self.messageTextField.text = ""
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension chatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if message.senderId == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as? ReceiverCell else {
                return UITableViewCell()
            }
            cell.lblReciveMessage.text = "\(message.message) \(message.createdAtHuman)"
            return cell
        } else if message.senderId == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell else {
                return UITableViewCell()
            }
            cell.lblsendMessage.text = "\(message.createdAtHuman) \(message.message)"
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell else {
                return UITableViewCell()
            }
            cell.lblsendMessage.text = "\(message.createdAtHuman) \(message.message)"
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.row]
        let width = tableView.frame.width - 30
        let height = message.message.height(withConstrainedWidth: width, font: UIFont.systemFont(ofSize: 16))
        return height + 30
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return boundingBox.height
    }
}
