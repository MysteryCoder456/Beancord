//
//  CreateGuildView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI
import FirebaseAuth

struct CreateGuildView: View {
    @ObservedObject var guildRepo: GuildRepository
    @State var guildName: String = ""
    
    @State var showingAlert = false
    @State var primaryAlertMessage = ""
    @State var secondaryAlertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("New Chat Guild")
                .font(.largeTitle)
            
            // Username Field
            HStack(alignment: .center) {
                Text("Name:")
                    .bold()
                
                TextField("Amazing Guild Name", text: $guildName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 5)
                    .stroke(Color.gray)
            )
            
            Spacer()

            Button(action: createGuild) {
                Text("Create")
                    .font(.title)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(primaryAlertMessage),
                    message: Text(secondaryAlertMessage),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
        }
        .padding(.horizontal)
    }
    
    func createGuild() {
        self.guildName = self.guildName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.guildName != "" {
            if let currentUser = Auth.auth().currentUser {
                
                let newGuild = Guild(id: UUID().uuidString, name: self.guildName, ownerID: currentUser.uid)
                guildRepo.createGuild(guild: newGuild)
                
                print("Created new guild with name \(self.guildName)")
                
                // Show guild creation alert
                self.primaryAlertMessage = "\(self.guildName) has been created!"
                self.secondaryAlertMessage = "Check it out in the Guilds tab. You may have to restart the app to view your new guild."
                self.showingAlert = true
                
                self.guildName = ""
                
            }
        }
    }
}

struct CreateGuildView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGuildView(guildRepo: GuildRepository())
    }
}
