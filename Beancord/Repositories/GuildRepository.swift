//
//  GuildRepository.swift
//  Beancord
//
//  Created by Rehatbir Singh on 03/13/2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class GuildRepository: ObservableObject {
    let db = Firestore.firestore()

    @Published var guilds: Array<Guild> = []
    @Published var ownedGuilds: Array<Guild> = []
    
    init() {
        readGuilds()
        readUserOwnedGuilds()
    }

    func createGuild(guild: Guild) {
        do {
            let _ = try db.collection("guilds").addDocument(from: guild)
        } catch { print(error) }
    }

    func readGuilds() {
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection("guilds").whereField("members", arrayContains: currentUserID).addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.guilds = querySnapshot.documents.compactMap { document in
                        do {
                            
                            let x = try document.data(as: Guild.self)
                            return x
                            
                        } catch { print(error) }

                        return nil
                    }
                }
            }
        }
    }
    
    func readUserOwnedGuilds() {
        if let currentUserID = Auth.auth().currentUser?.uid {
            db.collection("guilds").whereField("ownerID", isEqualTo: currentUserID).addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.ownedGuilds = querySnapshot.documents.compactMap { document in
                        do {
                            
                            let x = try document.data(as: Guild.self)
                            return x
                            
                        } catch { print(error) }

                        return nil
                    }
                }
            }
        }
    }
    
    func updateGuild(guild: Guild) {
        do {
            try db.collection("guilds").document(guild.id!).setData(from: guild)
        } catch {
            print(error)
        }
    }
}
