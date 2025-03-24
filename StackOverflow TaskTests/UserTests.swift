
import XCTest
@testable import StackOverflow_Task

final class UserTests: XCTestCase {
    /*
     Users represent data used to populate a cell in a list.
     each list item should have:
        - Username
        - Profile Picture
        - Reputation
     
     Users shuld be created from data retrieved from a network call
     */
    
    var sut: User!
    var networkHandler: NetworkHandling!
    
    override func setUp() {
        sut = User(name: "testUser", pfp: UIImage(), rep: 1)
        networkHandler = MockNetworkHandler(result: .success([User(name: "joe", pfp: UIImage(), rep: 1)]))
    }
    
    func test_user_containsName() {
        XCTAssertNotNil(sut.name)
    }
    
    func test_user_containsPFP() {
        XCTAssertNotNil(sut.pfp)
    }
    
    func test_user_containsReputation() {
        XCTAssertNotNil(sut.rep)
    }
}
