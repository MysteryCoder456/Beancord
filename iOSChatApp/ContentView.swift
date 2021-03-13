//
//  ContentView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var guildRepo = GuildRepository()
    
    init() {
        print(guildRepo.guilds)
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}