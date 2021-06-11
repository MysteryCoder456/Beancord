//
//  OtherView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

struct OtherView: View {
    @EnvironmentObject var envObjects: EnvObjects
    
    @ObservedObject var guildRepo: GuildRepository
    @ObservedObject var userRepo: UserRepository
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CreateGuildView(guildRepo: guildRepo)) {
                    Text("Create a chat guild")
                }
                
                NavigationLink(destination: AboutView()) {
                    Text("About Beancord")
                }
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        envObjects.authenticated = false
                    } catch {
                        print(error)
                    }
                }) {
                    Text("Sign Out")
                        .bold()
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Other")
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView(guildRepo: GuildRepository(), userRepo: UserRepository())
    }
}
