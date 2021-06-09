//
//  CreateGuildView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI
import FirebaseAuth

struct CreateGuildView: View {
    @ObservedObject var guildRepo = GuildRepository()
    @State var guildName: String = ""
    
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
        }
        .padding(.horizontal)
    }
    
    func createGuild() {
        self.guildName = self.guildName.trimmingCharacters(in: .whitespacesAndNewlines)
        if (self.guildName == "") { return }
        
        if let currentUser = Auth.auth().currentUser {
            let newGuild = Guild(id: UUID().uuidString, name: self.guildName, ownerID: currentUser.uid)
            guildRepo.createGuild(guild: newGuild)
            
            self.guildName = ""
            print("Created new guild with name \(self.guildName)")
        }
    }
}

struct CreateGuildView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGuildView()
    }
}
