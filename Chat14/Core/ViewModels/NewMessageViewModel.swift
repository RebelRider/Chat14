//
//  NewMessageViewModel.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import Firebase

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            await fetchAllUsers()
        }
    }
    
    @MainActor func fetchAllUsers() async {
        do {
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
            
            for user in users {
                if user.uid != Auth.auth().currentUser?.uid {
                    self.users.append(user)
                }
            }
        } catch {
            print("Failed to get users")
        }
    }
}
