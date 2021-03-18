//
//  ContentView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct GuildListView: View {
    @ObservedObject var guildRepo = GuildRepository()
    
    var body: some View {
        NavigationView() {
            let guilds = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? previewGuildList : guildRepo.guilds
            
            List(guilds) { guild in
                NavigationLink(destination: MessagesView(guild: guild)) {
                    GuildRowView(guild: guild)
                }
            }
            .navigationBarTitle("Beancord")
        }
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView()
    }
}