@testable import StackOverflow_Task
import UIKit

internal class MockNetworkHandler: NetworkHandling {
    let userResult: Result<[StackOverflow_Task.User], Error>
    let imageResult: Result<UIImage, Error>
    
    init(userResult: Result<[StackOverflow_Task.User], Error> = .failure(NetworkError.noData), imageResult: Result<UIImage, Error> = .failure(NetworkError.noData)) {
        self.userResult = userResult
        self.imageResult = imageResult
    }
    
    func getUsers(_ completion: @escaping (Result<[StackOverflow_Task.User], Error>) -> ()) {
        completion(userResult)
    }
    
    func getImage(from: String, _ completion: @escaping (Result<UIImage, Error>) -> ()) {
        completion(imageResult)
    }
}
