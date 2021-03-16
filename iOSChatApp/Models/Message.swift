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
