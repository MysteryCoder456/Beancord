//
//  BeancordApp.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

class EnvObjects: ObservableObject {
    @Published var authenticated = Auth.auth().currentUser != nil
}

@main
struct BeancordApp: App {
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
