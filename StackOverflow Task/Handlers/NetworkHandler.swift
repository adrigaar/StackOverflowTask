import Foundation
import UIKit

internal protocol NetworkHandling {
    func getUsers(_ completion: @escaping (Result<[User], Error>) -> ())
}

private let getUsersUrl: URL? = URL(string: "https://api.stackexchange.com/2.2/users?page=1&pagesize=20&order=desc&sort=reputation&site=stackoverflow")

internal class NetworkHandler: NetworkHandling {
    
    var urlSession: URLSessionHandling
    
    init(_ urlSession: URLSessionHandling = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getUsers(_ completion: @escaping (Result<[User], Error>) -> ()) {
        guard let url = getUsersUrl else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
//        completion(.failure(NetworkError.noData))
        urlSession.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(NetworkError.responseError(error: error)))
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                print(data)
                let result = try JSONDecoder().decode(GetUserResponse.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(NetworkError.unableToParseData))
            }
        }.resume()
    }
    
//    func getImage(from string: String) -> UIImage? {
//        guard let
//    }
//
}

protocol URLSessionHandling {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionHandling {
    
}
