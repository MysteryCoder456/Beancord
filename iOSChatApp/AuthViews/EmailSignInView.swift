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
            
            VStack(alignment: .center) {
                Text("Enter your Email:")
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .center) {
                Text("Enter your Password:")
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()

            Button(action: login) {
                Text("Login")
                    .font(.title)
            }
            
            Spacer()
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
