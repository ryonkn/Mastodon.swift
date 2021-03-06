import Foundation
import Moya

extension Mastodon {
    public enum FollowRequests {
        case followRequests
        case authorize(String)
        case reject(String)
    }
}

extension Mastodon.FollowRequests: TargetType {
    fileprivate var apiPath: String { return "/api/v1/follow_requests" }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        return Settings.shared.baseURL!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        switch self {
        case .followRequests:
            return "\(apiPath)"
        case .authorize(_):
            return "\(apiPath)/authorize"
        case .reject(_):
            return "\(apiPath)/reject"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        switch self {
        case .followRequests:
            return .get
        case .authorize(_), .reject(_):
            return .post
        }
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        switch self {
        case .followRequests:
            return nil
        case .authorize(let id), .reject(let id):
            return [
                "id": id
            ]
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
}
