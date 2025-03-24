import Foundation

final class FollowedHandler {
    static let shared = FollowedHandler()
    var followedIds: Set<Int>?
    private let userDefaultKey: String = "FollowedUsers"
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey) {
            followedIds = try? JSONDecoder().decode(Set<Int>.self, from: data)
        }
    }
    
    func toggleStatusOf(id: Int) {
        guard let unwrappedIds = followedIds else {
            followedIds = [id]
            save()
            return
        }
        
        if unwrappedIds.contains(id) {
            self.followedIds?.remove(id)
        } else {
            self.followedIds?.formUnion([id])
        }
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(followedIds) {
            UserDefaults.standard.set(encoded, forKey: userDefaultKey)
        }
    }
}
