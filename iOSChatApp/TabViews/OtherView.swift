//
//  OtherView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

struct OtherView: View {
    @EnvironmentObject var envObjects: EnvObjects
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        envObjects.authenticated = false
                    } catch {
                        print(error)
                    }
                }) {
                    Text("Sign Out")
                        .bold()
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Other")
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
