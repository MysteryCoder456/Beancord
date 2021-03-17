//
//  GuildRowView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI

struct GuildRowView: View {
    var guild: Guild
    
    var body: some View {
        HStack {
            Image(systemName: "person.3.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            Spacer()

            Text(guild.name)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
    }
}

struct GuildRowView_Previews: PreviewProvider {
    static var previews: some View {
        GuildRowView(guild: previewGuild)
            .previewLayout(.fixed(width: 350, height: 100))
    }
}
