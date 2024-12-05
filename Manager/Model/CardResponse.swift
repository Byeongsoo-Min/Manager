//
//  CardResponse.swift
//  Manager
//
//  Created by MBSoo on 11/14/24.
//

import Foundation

struct CardResponse: Decodable {
    let status: String?
    let cardId: Int?
    let message: String?
}
