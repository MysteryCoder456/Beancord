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
    var members: Array<String>
    
    init(id: String?, name: String, ownerID: String, members: Array<String> = []) {
        self.id = id;
        self.name = name
        self.ownerID = ownerID
        
        if members.isEmpty { self.members = [self.ownerID] }
        else { self.members = members }
    }
}

var previewGuild = Guild(id: UUID().uuidString, name: "Guild Name", ownerID: "1", members: ["1", "2", "3"])
var previewGuildList = [
    Guild(id: UUID().uuidString, name: "Guild 1", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 2", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 3", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "Guild 4", ownerID: UUID().uuidString)
]
var previewOwnedGuildList = [
    Guild(id: UUID().uuidString, name: "My Guild 1", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "My Guild 2", ownerID: UUID().uuidString),
    Guild(id: UUID().uuidString, name: "My Guild 3", ownerID: UUID().uuidString)
]
