import Foundation

enum APIErrors : Error {
    // More generalized versions of these cases can be formed for extensive error handling
    case requestFailed(error: NSError)
    case responseUnsuccessful
    case invalidData
    case invalidURL
    case jsonParsingFailure
}

// generic return type from the API call.
enum Result <Value, Error> {
    case success(Value)
    case failure(Error)
}
