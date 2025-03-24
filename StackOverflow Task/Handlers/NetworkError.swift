internal enum NetworkError: Error {
    case noData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "no data was able to be constructed from the call"
        }
    }
}
