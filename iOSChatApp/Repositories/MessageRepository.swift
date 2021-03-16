//
//  MessageRepository.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class MessageRepository: ObservableObject {
    var guild: Guild
    let db = Firestore.firestore()

    @Published var messages: Array<Message> = []
    
    init(currentGuild: Guild) {
        self.guild = currentGuild
        readMessages()
    }

    func createMessage(message: Message) {
        do {
            let _ = try db.collection("messages").addDocument(from: message)
        } catch {
            print(error)
        }
    }

    func readMessages() {
        db.collection("messages").whereField("guildID", isEqualTo: self.guild.id!).order(by: "dateSent").addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.messages = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Message.self)
                        return x
                    } catch {
                        print(error)
                    }

                    return nil
                }
            }
        }
    }
}

