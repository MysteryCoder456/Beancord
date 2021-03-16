//
//  MessagesView.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import SwiftUI

struct MessagesView: View {
    @State var message: String = ""
    
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
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
