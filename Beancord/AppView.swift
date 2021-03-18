//
//  AppView.swift
//  Beancord
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
                
                OtherView()
                    .tabItem {
                        Image(systemName: "tray.2.fill")
                        Text("Other")
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
