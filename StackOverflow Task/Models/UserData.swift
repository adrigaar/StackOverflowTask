
import UIKit

struct UserData: Codable {
    let id: Int
    let name: String
    let pfpUrl: String
    let rep: Int
    var isFollowed: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case pfpUrl = "profile_image"
        case rep = "reputation"
    }
}
