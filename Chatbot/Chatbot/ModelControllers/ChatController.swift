//
//  ChatController.swift
//  Chatbot
//
//  Created by Eric Andersen on 9/5/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation

// 1. Know what you are completing with for your function signature
// 2. URLSession
// 3. ^ Get your baseURL
// 4. ^ Build that url
// 5. Handle data and/or error from URLSession

class ChatController {
    
    // MARK: - Properties
    var chats: [Chat] = []
    let baseURL = URL(string: "https://messageing-app-f734a.firebaseio.com/")
    
    
    // MARK: - Functions
    func putChat(message: String, completion: @escaping (_ success: Bool) -> Void) {
        // create an instance of chat
        let chat = Chat(message: message)
        
        guard let url = baseURL?.appendingPathComponent(chat.uuid).appendingPathExtension("json") else { fatalError("bad built url") }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let jsonEncoder = JSONEncoder()
        do {
            // TODO come BACK
            let data = try jsonEncoder.encode(chat)
            request.httpBody = data
        } catch let error {
            print("Error JSONEncoder for chat: \(error) \(error.localizedDescription)")
            completion(false); return
        }
        
        // DataTask with urlRequest DOES NOT have a defined HTTP protocol. YOU have to define it!
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error with PUT request \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            // THIS IS JUST FOR THE DEVELOPER. We don't have to do this but its very good error handling
            guard let data = data,
                let responseString = String(data: data, encoding: .utf8) else { completion(false); return }
            print(responseString)
            
            // This will connect our local array(Source of truth) to the instance that we sent up to firebase.
            print("Is this chat on the main thread: \(Thread.isMainThread)")
            self.chats.append(chat)
            completion(true)
            
        }.resume()
    }
    
    func fetchChat(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let url = baseURL else { fatalError("bad base url") }
        let builtURL = url.appendingPathExtension("json")
        var request = URLRequest(url: builtURL)
        request.httpMethod = "GET"
        // because we are not posting a body to a server
        request.httpBody = nil
        
        // Because we are fetching, dataTask with URL as GET built in it. So US it. Right now this is how you do 'GET' (more practice - go team)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching with Data Task \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let data = data else { completion(false); return }
            do {
                let decoder = JSONDecoder()
                let chatsDictionary = try decoder.decode([String : Chat].self, from: data)
                let chats = chatsDictionary.compactMap({$0.value})
                // connect the chats that came back to OUR SOURCE OF TRUTH
                self.chats = chats
                completion(true)
            } catch let error {
                print("Error Decoding chat: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
        }.resume()
    }
}





























































