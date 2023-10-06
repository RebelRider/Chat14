//
//  HomeViewModel.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import Firebase

class HomeViewModel: ObservableObject {
    @Published var recentMessages = [RecentMessage]()
    var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        fetchRecentMessages()
    }
    
    private var listenerRegistration: ListenerRegistration?
    
    func fetchRecentMessages() {
        listenerRegistration?.remove()
        self.recentMessages.removeAll()
        
        listenerRegistration = Firestore.firestore().collection("recentMessages")
            .document(currentUser.uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener({ querySnapshot, error in
                if let error = error {
                    print("Failed to listen for recent messages \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if let rm = try? change.document.data(as: RecentMessage.self) {
                        if let index = self.recentMessages.firstIndex(where: { existingRm in
                            return existingRm.fromUid == rm.fromUid && existingRm.id == rm.id
                        }) {
                            self.recentMessages[index] = rm
                        } else {
                            self.recentMessages.insert(rm, at: 0)
                        }
                    } else {
                        print("Failed to decode document data as recent message.")
                    }
                })
            })
    }
}
