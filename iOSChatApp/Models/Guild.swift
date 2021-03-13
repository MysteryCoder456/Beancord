//
//  Guild.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Guild: Identifiable, Codable {
    @DocumentID var id = UUID().uuidString
    var name: String
    var messages: Array<Message>
}
