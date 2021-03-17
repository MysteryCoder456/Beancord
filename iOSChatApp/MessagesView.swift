//
//  MessagesView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI
import FirebaseAuth

class ScrollToModel: ObservableObject {
    enum Action {
        case top
        case bottom
    }
    
    @Published var direction: Action? = nil
}

struct MessagesView: View {
    var guild: Guild
    @ObservedObject var msgRepo: MessageRepository
    @State var message: String = ""
    @StateObject var vm = ScrollToModel()
    @ObservedObject var userRepo = UserRepository() {
        didSet {
            vm.direction = .bottom
        }
    }
    
    init(guild: Guild) {
        self.guild = guild
        msgRepo = MessageRepository(currentGuild: guild)
    }
    
    var body: some View {
        VStack {
            let messages = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? previewMessageList : msgRepo.messages
            
            ScrollView {
                ScrollViewReader { sp in
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            let msg: Message = message
                            let author = userRepo.users.first(where: { $0.userID == msg.authorID })
                            let isMyMsg = msg.authorID == Auth.auth().currentUser?.uid
                            
                            HStack {
                                if isMyMsg { Spacer() }
                            
                                VStack {
                                    Text(msg.content)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(sentByMe: isMyMsg))
                                        .frame(maxWidth: .infinity, alignment: isMyMsg ? .trailing : .leading)
                                    
                                    Text(author?.username ?? "Unknown")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: isMyMsg ? .trailing : .leading)
                                }
                                
                                if !isMyMsg { Spacer() }
                            }
                        }
                    }
                    .onAppear() {
                        vm.direction = .bottom
                    }
                    .onReceive(vm.$direction) { action in
                        guard !messages.isEmpty else { return }
                        
                        withAnimation {
                            switch action {
                            case .top:
                                sp.scrollTo(messages.first!, anchor: .top)
                                
                            case .bottom:
                                sp.scrollTo(messages.last!, anchor: .bottom)
                                
                            default:
                                return
                            }
                        }
                    }
                }
            }
            .navigationTitle(self.guild.name)
            .padding(.horizontal)
            
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
        self.message = self.message.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.message == "" { return }
        
        print("Sending message: \(self.message)")
        
        let currentUser = Auth.auth().currentUser
        if (currentUser == nil) { return }
        
        let msg = Message(id: UUID().uuidString, authorID: currentUser!.uid, guildID: self.guild.id!, content: self.message)
        msgRepo.createMessage(message: msg)
        self.message = ""
        vm.direction = .bottom
        
        print("Sent message without issues")
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(guild: previewGuild)
    }
}
