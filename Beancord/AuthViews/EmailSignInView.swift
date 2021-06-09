//
//  EmailSignInView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

struct EmailSignInView: View {
    @EnvironmentObject var envObjects: EnvObjects
    @State var email: String = ""
    @State var password: String = ""
    @State var register: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            VStack {
                VStack {
                    Text("Welcome to")
                    
                    Text("Beancord")
                        .font(.system(size: 60))
                        .bold()
                }
                .padding(.bottom, 30)
                
                Text("Please login to continue")
                
                VStack(spacing: 20) {
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
                }
            }
            .padding(.bottom, 30)
            
            Spacer()

            Button(action: login) {
                Text("Login")
                    .font(.title)
            }
            
            Button(action: { self.register = true }) {
                Text("Don't have an account?")
            }
            .sheet(isPresented: $register, content: { EmailRegisterView() })
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
