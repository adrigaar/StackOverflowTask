
import XCTest
@testable import StackOverflow_Task


final class NetworkHandlerTests: XCTestCase {
    /*
     NetworkHandler must be able to make network calls
     
     should abstract the logic so that it is easy to use and does not require specific knowledge
     
        - "getUser" function with default to simply get the users as this is the default function of the app
        - "getImage" function to return a UIImage from a url
     */
    
    var sut: NetworkHandling!
    
    override func setUp() {
        sut = NetworkHandler(MockURLSession(desiredResponse: .success([User(id: 1, name: "Joe", pfpUrl: "", rep: 1)])))
    }
    
    func test_networkHandler_returnsData_whenGetUsersIsCalledWithoutParameters() {
        sut.getUsers { result in
            switch result {
            case .success(let users):
                XCTAssertNotNil(users.first)
            case .failure(let error):
                let networkError = error as? NetworkError
                XCTAssertNotNil(networkError)
                XCTFail(networkError!.description)
            }
        }
    }
    
    func test_networkHandler_decodesDataIntoUsers_whenUserDataIsReturned() {
        sut.getUsers { result in
            switch result {
            case .success(let users):
                guard let user = users.first else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(user.id, 1)
                XCTAssertEqual(user.name, "Joe")
                XCTAssertEqual(user.pfpUrl, "")
                XCTAssertEqual(user.rep, 1)
            case .failure(let error):
                let networkError = error as? NetworkError
                XCTAssertNotNil(networkError)
                XCTFail(networkError!.description)
            }
        }
    }
}
