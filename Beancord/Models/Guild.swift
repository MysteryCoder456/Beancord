//
//  Guild.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Guild: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var ownerID: String
}

var previewGuild = Guild(id: UUID().uuidString, name: "Guild Name", ownerID: UUID().uuidString)
var previewGuildList = [
    Guild(id: UUID().uuidString, name: "Guild 1", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 2", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 3", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 4", ownerID: UUID().uuidString)
]
