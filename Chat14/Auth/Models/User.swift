
struct User: Identifiable, Codable, Hashable {
    var id: String {
        uid
    }
    
    let uid: String
    var email: String
    var username: String
    var profileImageUrl: String
}

let mockUsers = [
    User(uid: "1", email: "user1@mail.com", username: "User 1", profileImageUrl: "https://i.pravatar.cc/150?img=1"),
    User(uid: "2", email: "user2@mail.com", username: "User 2", profileImageUrl: "https://i.pravatar.cc/150?img=2"),
    User(uid: "3", email: "user3@mail.com", username: "User 3", profileImageUrl: "https://i.pravatar.cc/150?img=3"),
    User(uid: "4", email: "user4@mail.com", username: "User 4", profileImageUrl: "https://i.pravatar.cc/150?img=4")
]
