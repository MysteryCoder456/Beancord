//
//  CreateGuildView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/18/2021.
//

import SwiftUI

struct CreateGuildView: View {
    @ObservedObject var guildRepo = GuildRepository()
    @State var guildName: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            
            Text("New Chat Guild")
                .font(.largeTitle)
                .bold()
            
            // Username Field
            HStack(alignment: .center) {
                Text("Name:")
                TextField("Amazing Guild Name", text: $guildName)
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

            Button(action: createGuild) {
                Text("Create")
                    .font(.title)
            }
        }
        .padding(.horizontal)
    }
    
    func createGuild() {
        
    }
}

struct CreateGuildView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGuildView()
    }
}
