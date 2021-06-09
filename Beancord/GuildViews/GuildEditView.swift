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
        // This view doesn't have any NavigationLinks
        // It's just a NavigationView for the title on top
        NavigationView {
            List {
                VStack(spacing: 20) {
                    
                    HStack(alignment: .center) {
                        Text("Name:")
                            .bold()
                        
                        TextField("Your guild's name", text: $guild.name)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
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
    }
    
    func save() {
        
    }
}

struct GuildEditView_Previews: PreviewProvider {
    static var previews: some View {
        GuildEditView(guild: previewGuild)
    }
}
