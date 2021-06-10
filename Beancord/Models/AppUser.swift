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
}
