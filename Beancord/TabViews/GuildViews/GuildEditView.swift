//
//  GuildEditView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/19/2021.
//

import SwiftUI
import FirebaseAuth

struct GuildEditView: View {
    @State var guild: Guild
    @State var newMemberEmail = ""
    
    @State var showingAlert = false
    @State var primaryAlertMessage = ""
    @State var secondaryAlertMessage = ""
    
    @ObservedObject var guildRepo: GuildRepository
    @ObservedObject var userRepo: UserRepository
    
    var body: some View {
        List {
            
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
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(primaryAlertMessage),
                        message: Text(secondaryAlertMessage),
                        dismissButton: .default(Text("Dismiss"))
                    )
                }
                
            }
            
        }
        .navigationTitle("Editing Guild")
        .navigationBarItems(trailing:
            Button(action: saveDetails) {
                HStack {
                    Spacer()
                    Text("Save")
                        .foregroundColor(.blue)
                    Spacer()
                }
            })
    }
    
    func saveDetails() {
        guildRepo.updateGuild(guild: self.guild)
        print("Guild details updated for \(self.guild.name)")
        
        // Display alert
        self.primaryAlertMessage = "Saved!"
        self.secondaryAlertMessage = "Guild settings have been saved. You may have to restart the app for the changes to take effect."
        self.showingAlert = true
    }
    
    func addMember() {
        if let newMember = userRepo.users.first(where: { $0.email == self.newMemberEmail }) {
            
            // A user with the corresponding email address was found
            
            // Check if user is already a part of this guild
            if self.guild.members.contains(newMember.userID) {
                
                self.primaryAlertMessage = "Unable to add member"
                self.secondaryAlertMessage = "\(newMember.username) is already a part of this guild"
                self.showingAlert = true
                
            } else {
            
                self.guild.members.append(newMember.userID)
                self.primaryAlertMessage = "\(newMember.username) has been added"
                self.secondaryAlertMessage = "A new user was sucessfully added to this guild."
                self.showingAlert = true
                
                self.guildRepo.updateGuild(guild: self.guild)
                print("\(newMember.username) has been added to \(self.guild.name)")
                
            }
            
            // Clear the textfield
            self.newMemberEmail = ""
            
        } else {
            
            // No user was found :(
            self.primaryAlertMessage = "Unable to add member"
            self.secondaryAlertMessage = "A user with this email address was not found, please check if the email you entered is correct."
            self.showingAlert = true
            
        }
    }
}

struct GuildEditView_Previews: PreviewProvider {
    static var previews: some View {
        GuildEditView(guild: previewGuild, guildRepo: GuildRepository(), userRepo: UserRepository())
    }
}
