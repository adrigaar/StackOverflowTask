@testable import StackOverflow_Task
import Foundation

internal class MockURLSession: URLSessionHandling {
    let desiredResponse: Result<Data, Error>
    
    init(desiredResponse: Result<Data, Error>) {
        self.desiredResponse = desiredResponse
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(desiredOutcome: desiredResponse, completion: completionHandler)
    }
}

private class MockURLSessionDataTask: URLSessionDataTask {
    let desiredOutcome: Result<Data, Error>
    let completion: @Sendable (Data?, URLResponse?, Error?) -> Void
    
    init(desiredOutcome: Result<Data, Error>, completion: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        self.desiredOutcome = desiredOutcome
        self.completion = completion
    }
    
    override func resume() {
        switch desiredOutcome {
        case .success(let success):
            completion(success, nil, nil)
        case .failure(let failure):
            completion(nil, nil, failure)
        }
    }
}
