//
//  ProfileView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 06/13/2021.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var userRepo: UserRepository
    @State var user: AppUser
    
    @State var primaryAlertMessage: String = ""
    @State var secondaryAlertMessage: String = ""
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            
            // TODO: Replace "bean" with a proper picture after adding pfp uploading
            Image("bean")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Text(user.username)
                .font(.title2)
            
            GroupBox {
                    
                HStack {
                    Text("Username:")
                        .bold()
                    
                    TextField("Change your username", text: $user.username)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Divider()
                
                HStack {
                    Text("Email:")
                        .bold()
                    
                    TextField("Change your email", text: $user.email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Divider()
                
                Button(action: saveDetails) {
                    Text("Save")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(primaryAlertMessage),
                        message: Text(secondaryAlertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                    
            }
            .padding(.horizontal)
                
            Spacer()
            
        }
        .navigationTitle("My Profile")
        
    }
    
    func saveDetails() {
        if let currentUser = Auth.auth().currentUser {
            currentUser.updateEmail(to: self.user.email, completion: { error in
                if let error = error {
                    
                    print(error)
                    self.primaryAlertMessage = "Unable to update details"
                    self.secondaryAlertMessage = error.localizedDescription
                    self.showingAlert = true
                    
                } else {
                    
                    // TODO: Add field value checks
                    self.userRepo.updateUser(user: self.user)
                    self.primaryAlertMessage = "Details updated succesfully"
                    self.secondaryAlertMessage = "Your accounts details were changed successfully."
                    self.showingAlert = true
                    
                }
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userRepo: UserRepository(), user: previewUser)
    }
}
