//
//  UserRepository.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/16/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
    let db = Firestore.firestore()

    @Published var users: Array<AppUser> = []
    
    init() {
        readUsers()
    }

    func createUser(user: AppUser) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch {
            print(error)
        }
    }

    func readUsers() {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.users = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: AppUser.self)
                        return x
                    } catch {
                        print(error)
                    }

                    return nil
                }
            }
        }
    }
    
    func updateUser(user: AppUser) {
        do {
            try db.collection("users").document(user.id!).setData(from: user)
        } catch {
            print(error)
        }
    }
}
