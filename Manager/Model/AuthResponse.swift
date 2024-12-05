//
//  AuthResponse.swift
//  Manager
//
//  Created by MBSoo on 12/1/24.
//

import Foundation

struct AuthResponse : Codable {
    var status: String
    var message: String
    var manager_name: String?
    var member_id: Int?
}
