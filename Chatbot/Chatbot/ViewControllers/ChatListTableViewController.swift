//
//  ChatListTableViewController.swift
//  Chatbot
//
//  Created by Eric Andersen on 9/5/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController {
    
    let chatController = ChatController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // little network spinner in the status bar.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        chatController.fetchChat { (success) in
            
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.title = "No Chats"
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            }
        }
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatController.chats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        let chat = chatController.chats[indexPath.row]

        // Configure the cell...
        cell.textLabel?.text = chat.message

        return cell
    }
}
