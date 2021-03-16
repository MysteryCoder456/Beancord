//
//  iOSChatAppApp.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI
import Firebase

class EnvObjects: ObservableObject {
    @Published var authenticated = Auth.auth().currentUser != nil
}

@main
struct iOSChatAppApp: App {
    var envObjects: EnvObjects
    
    init() {
        FirebaseApp.configure()
        envObjects = EnvObjects()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView().environmentObject(envObjects)
        }
    }
}
