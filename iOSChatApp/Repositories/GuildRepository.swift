//
//  GuildRepository.swift
//  iOSChatApp
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class GuildRepository: ObservableObject {
    let db = Firestore.firestore()

    @Published var guilds: Array<Guild> = []
    
    init() {
        readGuilds()
    }

    func createGuild(guild: Guild) {
        do {
            let _ = try db.collection("guilds").addDocument(from: guild)
        } catch {
            print(error)
        }
    }

    func readGuilds() {
        db.collection("guilds").addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.guilds = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Guild.self)
                        return x
                    } catch {
                        print(error)
                    }

                    return nil
                }
            }
        }
    }
    
//    func readUserOwnedGuilds() {
//        if let currentUserID = Auth.auth().currentUser?.uid {
//            db.collection("guilds").whereField("ownerID", isEqualTo: currentUserID).addSnapshotListener { querySnapshot, error in
//                if let querySnapshot = querySnapshot {
//                    self.userOwnedGuilds = querySnapshot.documents.compactMap { document in
//                        do {
//                            let x = try document.data(as: Guild.self)
//                            return x
//                        } catch {
//                            print(error)
//                        }
//
//                        return nil
//                    }
//                }
//            }
//        }
//    }
    
    func updateGuild(guild: Guild) {
        do {
            try db.collection("guild").document(guild.id!).setData(from: guild)
        } catch {
            print(error)
        }
    }
}
