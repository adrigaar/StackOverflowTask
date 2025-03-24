
import XCTest
@testable import StackOverflow_Task


final class NetworkHandlerTests: XCTestCase {
    /*
     NetworkHandler must be able to make network calls
     
     should abstract the logic so that it is easy to use and does not require specific knowledge
     
        - "get" function with default to simply get the users as this is the default function of the app
        - option to override default of "get" to stipulate own endpoint for data
     */
    
    var sut: NetworkHandling!
    
    override func setUp() {
        sut = NetworkHandler()
    }
    
    func test_networkHandler_returnsData_whenGetIsCalledWithoutParameters() {
        sut.getUsers { result in
            switch result {
            case .success(let users):
                XCTAssertNotNil(users.first)
                break;
            case .failure(let error):
                let networkError = error as? NetworkError
                XCTAssertNotNil(networkError)
                XCTFail(networkError!.description)
            }
        }
    }
}
