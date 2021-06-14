//
//  OtherView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import Firebase

struct OtherView: View {
    @EnvironmentObject var envObjects: EnvObjects
    
    @ObservedObject var guildRepo: GuildRepository
    @ObservedObject var userRepo: UserRepository
    
    let currentUser: AppUser?
    
    init(guildRepo: GuildRepository, userRepo: UserRepository) {
        self.guildRepo = guildRepo
        self.userRepo = userRepo
        
        let currentUserID = Auth.auth().currentUser?.uid
        self.currentUser = userRepo.users.first(where: { $0.userID == currentUserID })
    }
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ProfileView(userRepo: userRepo, user: currentUser ?? previewUser)) {
                    Text("My Profile")
                }
                
                NavigationLink(destination: CreateGuildView(guildRepo: guildRepo)) {
                    Text("Create a chat guild")
                }
                
                NavigationLink(destination: AboutView()) {
                    Text("About Beancord")
                }
                
                Button(action: signOut) {
                    Text("Sign Out")
                        .bold()
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Other")
        }
    }
    
    func signOut() {
        do {
            
            try Auth.auth().signOut()
            envObjects.authenticated = false
            
        } catch { print(error) }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView(guildRepo: GuildRepository(), userRepo: UserRepository())
    }
}
