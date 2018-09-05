//
//  ChatViewController.swift
//  Chatbot
//
//  Created by Eric Andersen on 9/5/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    // we are not using a sharedInstance so we have to create an instance outside of it's class. but within where we want to use it
    let chatController = ChatController()

    @IBOutlet weak var chatLogo: UILabel!
    @IBOutlet weak var chatTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func sendChatButtonTapped(_ sender: UIButton) {
        
        guard let message = chatTextBox.text else { return }
        chatController.putChat(message: message) { (success) in
            
            if success {
                // do something.
                DispatchQueue.main.async {
                    self.chatLogo.text = "🎩"
                    self.chatTextBox.text = ""
                    print("Went to firebase")
                }
            } else {
                // do something else if it doesn't work.
                self.chatLogo.text = "🧟‍♂️"
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
