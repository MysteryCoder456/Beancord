//
//  GuildEditView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/19/2021.
//

import SwiftUI

struct GuildEditView: View {
    @State var guild: Guild
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                HStack(alignment: .center) {
                    Text("Name:")
                        .bold()
                    
                    TextField("Your guild's name", text: $guild.name)
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
            .frame(width: .infinity, height: .infinity)
            .padding(.horizontal)
        }
        .navigationTitle("Editing Guild")
        .navigationBarItems(trailing:
            Button(action: save) {
                Text("Save")
            }
        )
    }
    
    func save() {
        
    }
}

struct GuildEditView_Previews: PreviewProvider {
    static var previews: some View {
        GuildEditView(guild: previewGuild)
    }
}
