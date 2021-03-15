//
//  iOSChatAppApp.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI
import Firebase

@main
struct iOSChatAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            GuildListView()
        }
    }
}
