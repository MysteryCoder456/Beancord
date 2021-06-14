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
            
            // TODO: Add ability to update these details
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
                    
            }
            .padding(.horizontal)
                
            Spacer()
            
        }
        .navigationTitle("My Profile")
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userRepo: UserRepository(), user: previewUser)

    }
}
