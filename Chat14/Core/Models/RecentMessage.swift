import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Identifiable, Codable {
    @DocumentID var id: String?
    let fromUid: String
    let toUid: String
    let username: String
    let profileImageUrl: String
    let text: String
    let timestamp: Timestamp
}
