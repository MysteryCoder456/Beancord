//
//  ContentView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct GuildListView: View {
    @ObservedObject var guildRepo = GuildRepository()
    @State var editMode: Bool = false
    
    var body: some View {
        NavigationView() {
            let guilds = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? previewGuildList : guildRepo.guilds
            let ownedGuilds = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? previewOwnedGuildList : guildRepo.ownedGuilds
            
            List(self.editMode ? ownedGuilds : guilds) { guild in
                
                if self.editMode {
                    NavigationLink(destination: GuildEditView(guild: guild)) {
                        GuildRowView(guild: guild)
                    }
                } else {
                    NavigationLink(destination: MessagesView(guild: guild)) {
                        GuildRowView(guild: guild)
                    }
                }
                
            }
            .navigationBarTitle("Beancord")
            .navigationBarItems(trailing:
                Button(action: { self.editMode.toggle() }) {
                    Text(self.editMode ? "Done" : "Edit")
                }
            )
        }
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView()
    }
}
