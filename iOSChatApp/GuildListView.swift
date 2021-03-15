//
//  ContentView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct GuildListView: View {
    @ObservedObject var guildRepo = GuildRepository()
    
    var body: some View {
        Text("yeet")
    }
}

struct GuildListView_Previews: PreviewProvider {
    static var previews: some View {
        GuildListView()
    }
}
