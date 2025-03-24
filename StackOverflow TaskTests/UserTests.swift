
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
        networkHandler = MockNetworkHandler()
    }
    
    func user_containsName() {
        XCTAssertNotNil(sut.name)
    }
    
    func user_containsPFP() {
        XCTAssertNotNil(sut.pfp)
    }
    
    func user_containsReputation() {
        XCTAssertNotNil(sut.rep)
    }
    
    func user_canBeCreatedFromData_whenNetworkCallReturnsData() {
        
    }
    
}
