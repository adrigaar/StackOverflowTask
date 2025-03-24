import Foundation

class User {
    let id: Int
    let name: String
    let rep: Int
    let pfpUrl: String
    var isFollowed: Bool
    
    init(fromUserData userData: UserData) {
        self.id = userData.id
        self.name = userData.name
        self.rep = userData.rep
        self.pfpUrl = userData.pfpUrl
        self.isFollowed = FollowedHandler.shared.followedIds?.contains(userData.id) ?? false
    }
    
    func followToggled() {
        isFollowed.toggle()
        FollowedHandler.shared.toggleStatusOf(id: id)
    }
}
