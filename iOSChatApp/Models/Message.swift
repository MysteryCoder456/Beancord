//
//  Message.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var authorID: String
    var guildID: String
    var content: String
    var dateSent = Date()
}

var previewMessageList = [
    Message(id: UUID().uuidString, authorID: "uWnt9eEpTWNOnXUxqxnx5DiSK9K2", guildID: previewGuild.id!, content: "Hello"),
    Message(id: UUID().uuidString, authorID: "uWnt9eEpTWNOnXUxqxnx5DiSK9K2", guildID: previewGuild.id!, content: "How do you do?"),
    Message(id: UUID().uuidString, authorID: "uWnt9eEpTWNOnXUxqxnx5DiSK9K2", guildID: previewGuild.id!, content: "I'm great"),
    Message(id: UUID().uuidString, authorID: "uWnt9eEpTWNOnXUxqxnx5DiSK9K2", guildID: previewGuild.id!, content: "This is a test...")
]
