//
//  EmailRegisterView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

struct EmailRegisterView: View {
    @EnvironmentObject var envObjects: EnvObjects
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @State var showingAlert = false
    @State var primaryAlertMessage = ""
    @State var secondaryAlertMessage = ""
    
    var body: some View {
        VStack(spacing: 13) {
            Spacer()
            
            Text("Register with Email")
                .font(.largeTitle)
                .bold()
            
            // Username Field
            HStack(alignment: .center) {
                Text("Username:")
                    .bold()
                
                TextField("cool_nick_name", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 5)
                    .stroke(Color.gray)
            )
            
            // Email Field
            HStack(alignment: .center) {
                Text("Email:")
                    .bold()
                
                TextField("you@example.com", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 5)
                    .stroke(Color.gray)
            )
            
            // Password Field
            HStack(alignment: .center) {
                Text("Password:")
                    .bold()
                
                SecureField("p@ssw0rd", text: $password)
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

            Button(action: register) {
                Text("Register")
                    .font(.title)
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
    }
    
    func register() {
        Auth.auth().createUser(withEmail: self.email, password: self.password, completion: {result, error in
            if let error = error {
                
                print(error)
                
                // Show error alert
                self.primaryAlertMessage = "Unable to register"
                self.secondaryAlertMessage = error.localizedDescription
                self.showingAlert = true
                
            } else {
                
                let userRepo = UserRepository()
                let newUser = AppUser(id: UUID().uuidString, userID: result!.user.uid, username: self.username, email: self.email)
                
                // TODO: Add field value checks
                userRepo.createUser(user: newUser)
                
                self.username = ""
                self.email = ""
                self.password = ""

                print("\(self.email) has been registered with username \(self.username)!")
                envObjects.authenticated = true
                
            }
        })
    }
}

struct EmailRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        EmailRegisterView()
    }
}
