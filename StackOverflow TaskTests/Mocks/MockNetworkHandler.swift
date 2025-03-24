@testable import StackOverflow_Task

internal class MockNetworkHandler: NetworkHandling {
    var result: Result<[StackOverflow_Task.User], Error>
    
    init(result: Result<[StackOverflow_Task.User], Error>) {
        self.result = result
    }
    
    func getUsers(_ completion: @escaping (Result<[StackOverflow_Task.User], Error>) -> ()) {
        completion(result)
    }
}
