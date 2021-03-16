//
//  MessagesView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    var guild: Guild
    @ObservedObject var msgRepo: MessageRepository
    @State var message: String = ""
    
    init(guild: Guild) {
        self.guild = guild
        msgRepo = MessageRepository(currentGuild: guild)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                TextField("Message", text: $message)
                    .padding(.vertical)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func sendMessage() {
        print("Sending message: \(message)")
        
        let currentUser = Auth.auth().currentUser
        if (currentUser == nil) { return }
        
        let msg = Message(id: UUID().uuidString, authorID: currentUser!.uid, guildID: self.guild.id!, content: message)
        msgRepo.createMessage(message: msg)
        message = ""
        
        print("Sent message without issues")
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(guild: previewGuild)
    }
}
