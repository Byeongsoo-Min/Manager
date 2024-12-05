//
//  ManagerApp.swift
//  Manager
//
//  Created by MBSoo on 10/7/24.
//

import SwiftUI

@main
struct ManagerApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().getManagerName() != "" {
                TabBarView()
            } else {
                FirstView()
            }
        }
    }
}
