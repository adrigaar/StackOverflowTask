import Foundation
import UIKit

internal protocol NetworkHandling {
    func getUsers(_ completion: @escaping (Result<[User], Error>) -> ())
    func getImage(from: String, _ completion: @escaping (Result<UIImage, Error>) -> ())
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
                let users = try JSONDecoder().decode(GetUserResponse.self, from: data)
                    .items
                    .map({ userData in
                        User(fromUserData: userData)
                    })
                completion(.success(users))
            } catch {
                completion(.failure(NetworkError.unableToParseData))
            }
        }.resume()
    }
    
    func getImage(from string: String, _ completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: string) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(NetworkError.unableToParseData))
                return
            }
            completion(.success(image))
        }.resume()
    }

}

protocol URLSessionHandling {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionHandling {
    
}
