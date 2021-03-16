//
//  EmailSignInView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import Firebase

struct EmailSignInView: View {
    @EnvironmentObject var envObjects: EnvObjects
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack {
                Text("Login with Email")
                    .font(.largeTitle)
                    .bold()
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Text("Email:")
                TextField("you@example.com", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray)
            )
            
            HStack(alignment: .center) {
                Text("Password:")
                SecureField("p@ssw0rd", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray)
            )
            
            Spacer()

            Button(action: login) {
                Text("Login")
                    .font(.title)
            }
        }
        .padding(.horizontal)
    }
    
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: {result, error in
            if let error = error {
                print(error)
                self.password = ""
            } else {
                print("\(self.email) has been logged in!")
                self.email = ""
                self.password = ""
                envObjects.authenticated = true
            }
        })
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSignInView()
    }
}
