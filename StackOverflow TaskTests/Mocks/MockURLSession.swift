@testable import StackOverflow_Task
import Foundation

internal class MockURLSession: URLSessionHandling {
    let desiredResponse: Result<[User], Error>
    
    init(desiredResponse: Result<[User], Error>) {
        self.desiredResponse = desiredResponse
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(desiredOutcome: desiredResponse, completion: completionHandler)
    }
}

private class MockURLSessionDataTask: URLSessionDataTask {
    let desiredOutcome: Result<[User], Error>
    let completion: @Sendable (Data?, URLResponse?, Error?) -> Void
    
    init(desiredOutcome: Result<[User], Error>, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        self.desiredOutcome = desiredOutcome
        self.completion = completion
    }
    
    override func resume() {
        switch desiredOutcome {
        case .success(let success):
            // Because the mock is ONLY used it unit tests, force unwrapping is actually preferable because it causes the code to fail faster and the exception to direct us to a useful place.
            completion(try! JSONEncoder().encode(success), nil, nil)
        case .failure(let failure):
            completion(nil, nil, failure)
        }
    }
}
