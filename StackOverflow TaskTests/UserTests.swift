
import XCTest
@testable import StackOverflow_Task

final class UserTests: XCTestCase {
    /*
     Users represent data used to populate a cell in a list.
     each list item should have:
        - Username
        - Profile Picture
        - Reputation
     
     Users should be created from data retrieved from a network call
     */
    
    var sut: User!
    var networkHandler: NetworkHandling!
    let defaultUser = User(fromUserData: UserData(id: 1, name: "testUser", pfpUrl: "", rep: 1))
    
    override func setUp() {
        sut = defaultUser
        networkHandler = MockNetworkHandler(userResult: .success([defaultUser]))
    }
    
    func test_user_containsID() {
        XCTAssertNotNil(sut.id)
    }
    
    func test_user_containsName() {
        XCTAssertNotNil(sut.name)
    }
    
    func test_user_containsPfpUrl() {
        XCTAssertNotNil(sut.pfpUrl)
    }
    
    func test_user_containsReputation() {
        XCTAssertNotNil(sut.rep)
    }
    
    func test_followToggled_updatesFollowBool() {
        let initialFollow = sut.isFollowed
        sut.followToggled()
        XCTAssertNotEqual(sut.isFollowed, initialFollow)
    }
}
