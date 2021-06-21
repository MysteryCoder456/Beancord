//
//  AppUser.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AppUser: Identifiable, Codable {
    @DocumentID var id: String?  // This is not user's ID, this is the ID of the document that holds this info
    var userID: String  // This is the user ID that is registered in Firebase Auth services
    var username: String
    var email: String
    var dateJoined = Date()
    var profileImage: String?
}

let previewUser = AppUser(id: UUID().uuidString, userID: "1", username: "Username", email: "user@mail.com")
let previewUsers = [
    AppUser(id: UUID().uuidString, userID: "1", username: "User 1", email: "user1@mail.com"),
    AppUser(id: UUID().uuidString, userID: "2", username: "User 2", email: "user2@mail.com"),
    AppUser(id: UUID().uuidString, userID: "3", username: "User 3", email: "user3@mail.com"),
]
