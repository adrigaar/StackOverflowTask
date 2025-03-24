
internal protocol NetworkHandling {
    func getUsers(_ completion: @escaping (Result<[User], Error>) -> ())
}

internal class NetworkHandler: NetworkHandling {
    
    func getUsers(_ completion: @escaping (Result<[User], Error>) -> ()) {
        completion(.failure(NetworkError.noData))
    }
    
}
