//
//  ContentView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI
import FirebaseAuth

struct GuildListView: View {
    @ObservedObject var guildRepo: GuildRepository
    @ObservedObject var userRepo: UserRepository
    
    @State var editMode: Bool = false
    
    let runningInPreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    var currentUsername: String?
    
    init(guildRepo: GuildRepository, userRepo: UserRepository) {
        self.guildRepo = guildRepo
        self.userRepo = userRepo
        
        let currentUserID = Auth.auth().currentUser?.uid
        self.currentUsername = runningInPreviews ? previewUser.username : userRepo.users.first(where: { $0.userID == currentUserID })?.username
    }
    
    var body: some View {
        NavigationView() {
            let guilds = runningInPreviews ? previewGuildList : guildRepo.guilds
            let ownedGuilds = runningInPreviews ? previewOwnedGuildList : guildRepo.ownedGuilds
            
            // TODO: Add delete button that appears in edit mode
            List(self.editMode ? ownedGuilds : guilds) { guild in
                
                if self.editMode {
                    NavigationLink(destination: GuildEditView(guild: guild, guildRepo: guildRepo, userRepo: userRepo)) {
                        GuildRowView(guild: guild)
                    }
                } else {
                    NavigationLink(destination: MessagesView(guild: guild, userRepo: userRepo)) {
                        GuildRowView(guild: guild)
                    }
                }
                
            }
            .navigationBarTitle("Beancord")
            .navigationBarItems(
                
                leading: HStack {
                    
                    Image("bean")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                        
                    Text("Logged in as \(currentUsername ?? "")")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                
                },
                
                trailing: Button(action: { self.editMode.toggle() }) {
                    Text(self.editMode ? "Done" : "Edit")
                }
                
            )
        }
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView(guildRepo: GuildRepository(), userRepo: UserRepository())
    }
}
