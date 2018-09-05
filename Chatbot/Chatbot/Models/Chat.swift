//
//  Chat.swift
//  Chatbot
//
//  Created by Eric Andersen on 9/5/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation

struct Chat: Codable {
    
    let message: String
    let uuid: String = UUID().uuidString
}
