//
//  ContentView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct GuildListView: View {
    @ObservedObject var guildRepo = GuildRepository()
    
    var body: some View {
        NavigationView() {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                // SwiftUI Previews
                List(previewGuildList) { guild in
                    NavigationLink(destination: MessagesView(guild: guild)) {
                        GuildRowView(guild: guild)
                    }
                }
                .navigationBarTitle("Chat Guilds")
                
            } else {
                // Normal
                List(guildRepo.guilds) { guild in
                    NavigationLink(destination: MessagesView(guild: guild)) {
                        GuildRowView(guild: guild)
                    }
                }
                .navigationBarTitle("Chat Guilds")
            }
        }
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView()
    }
}
