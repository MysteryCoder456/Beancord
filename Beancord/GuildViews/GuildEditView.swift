//
//  GuildEditView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/19/2021.
//

import SwiftUI

struct GuildEditView: View {
    @State var guild: Guild
    @State var newMemberEmail = ""
    var repository: GuildRepository
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        List {
                
            Button(action: saveDetails) {
                HStack {
                    Spacer()
                    Text("Save")
                    Spacer()
                }
            }
            
            HStack {
                Text("Name:")
                    .bold()
                
                TextField("Your guild's name", text: $guild.name)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            HStack {
                
                TextField("Add Member (Email)", text: $newMemberEmail)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Button(action: addMember) {
                    Text("Add")
                }
            }
            
        }
    }
    
    func saveDetails() {
        repository.updateGuild(guild: guild)
    }
    
    func addMember() {
        
    }
}

struct GuildEditView_Previews: PreviewProvider {
    static var previews: some View {
        GuildEditView(guild: previewGuild, repository: GuildRepository())
    }
}
