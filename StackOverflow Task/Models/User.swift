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
        self.isFollowed = false //Pull this from persistence
    }
    
    func followToggled() {
        isFollowed.toggle()
    }
}
