//
//  ChatRequestModel.swift
//  Manager
//
//  Created by MBSoo on 12/6/24.
//

import Foundation

struct ChatRequestModel: Codable {
    let model: String
    var messages: [Message]
    let member_id: Int
}

struct Message: Codable {
    let role: String
    let content: String
}
