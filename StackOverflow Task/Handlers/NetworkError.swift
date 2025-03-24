internal enum NetworkError: Error {
    case noData
    case invalidUrl
    case responseError(error: Error)
    case unableToParseData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "no data was able to be constructed from the call"
        case .invalidUrl:
            return "unable to construct a valid URL"
        case .responseError(let error):
            return error.localizedDescription
        case .unableToParseData:
            return "Unable to Parse Data into expected type"
        }
    }
}
