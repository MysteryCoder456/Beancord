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
    @DocumentID var id: String?
    var userID: String
    var username: String
    var dateJoined = Date()
}
