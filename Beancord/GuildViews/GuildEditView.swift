//
//  GuildEditView.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/19/2021.
//

import SwiftUI

struct GuildEditView: View {
    @State var guild: Guild
    var repository: GuildRepository
    
    var body: some View {
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
            .padding(.horizontal)
            
            Button(action: save) {
                HStack {
                    Spacer()
                    Text("Save")
                    Spacer()
                }
            }
        }
    }
    
    func save() {
        repository.updateGuild(guild: guild)
    }
}

struct GuildEditView_Previews: PreviewProvider {
    static var previews: some View {
        GuildEditView(guild: previewGuild, repository: GuildRepository())
    }
}
