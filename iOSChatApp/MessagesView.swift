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
            let messages = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? previewMessageList : msgRepo.messages
            
            List(messages) { message in
                let msg: Message = message
                let isMyMsg = msg.authorID == Auth.auth().currentUser?.uid
                
                HStack {
                    if isMyMsg {
                        Spacer()
                    }
                    
                    Text(msg.content)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(ChatBubble(sentByMe: isMyMsg))
                    
                    if !isMyMsg {
                        Spacer()
                    }
                }
            }
            
            HStack {
                TextField("Message", text: $message)
                    .padding(.vertical)
                    .padding(.leading, 10)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing, 10)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray)
            )
            .edgesIgnoringSafeArea(.all)
            .padding(5)
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
