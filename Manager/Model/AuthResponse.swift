//
//  AuthResponse.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation

struct AuthResponse : Codable {
    var member_id: Int?
    var manager_name: String?
    var message: String?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
            case member_id
            case manager_name
            case message
            case status
        }
}
