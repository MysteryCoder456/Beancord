//
//  ContentView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct GuildListView: View {
    @ObservedObject var guildRepo = GuildRepository()
    @State var guilds: Array<Guild>?
    
    var body: some View {
        NavigationView() {
            List(guilds ?? previewGuildList) { guild in
                GuildRowView(guild: guild)
            }
            .navigationBarTitle("Chat Guilds")
        }
        .onAppear() {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                guilds = previewGuildList
            } else {
                guilds = guildRepo.guilds
            }
        }
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView()
    }
}
