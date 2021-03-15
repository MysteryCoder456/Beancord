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
    @DocumentID var id: String?
    var name: String
}

var previewGuild = Guild(id: UUID().uuidString, name: "Guild Name")
