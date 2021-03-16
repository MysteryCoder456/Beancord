//
//  AppView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var envObjects: EnvObjects
    
    var body: some View {
        if envObjects.authenticated {
            TabView() {
                GuildListView()
                    .tabItem {
                        Image(systemName: "bubble.left.fill")
                        Text("Guilds")
                    }
            }
        } else {
            EmailSignInView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
