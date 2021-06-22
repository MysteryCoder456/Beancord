//
//  BeancordApp.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class EnvObjects: ObservableObject {
    @Published var authenticated: Bool
    @Published var profileImages: Dictionary<String, UIImage> = [:]
    let profileImageSizeLimitMegaBytes: Int64 = 5
    
    init() {
        self.authenticated = Auth.auth().currentUser != nil
        
        if let currentUserID: String = Auth.auth().currentUser?.uid {
            
            let storageRef = Storage.storage().reference(withPath: "profileImages/\(currentUserID).jpg")
            
            storageRef.getData(maxSize: profileImageSizeLimitMegaBytes * 1048576 ) { [weak self] data, error in
                
                if let error = error {
                    print("Error occurred while retrieving profile image: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    if let image = UIImage(data: data) {
                        self?.profileImages[currentUserID] = image
                        return
                    }
                }
                
                // Default profile image
                self?.profileImages[currentUserID] = UIImage(named: "bean")
                
            }
            
        }
    }
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
            AppView()
                .environmentObject(envObjects)
        }
    }
}
