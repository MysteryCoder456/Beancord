//
//  AppView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var envObjects: EnvObjects
    
    // Pass these repositories into other views
    @ObservedObject var guildRepo = GuildRepository()
    @ObservedObject var userRepo = UserRepository()
    
    var body: some View {
        if envObjects.authenticated {
            TabView() {
                GuildListView(guildRepo: guildRepo, userRepo: userRepo)
                    .tabItem {
                        Image(systemName: "bubble.left.fill")
                        Text("Guilds")
                    }
                
                OtherView(guildRepo: guildRepo, userRepo: userRepo)
                    .tabItem {
                        Image(systemName: "tray.2.fill")
                        Text("Other")
                    }
            }
        } else {
            EmailSignInView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
