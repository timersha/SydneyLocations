import Foundation
import Alamofire

typealias GenericResponse<T> = (model: T?, error: Error?)

protocol NetworkServiceProtocol {
    func getDefaultLocations() async -> GenericResponse<Locations>
}

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    private let parser: Parsable.Type
    private let maxWaitTime = 15.0
    var commonHeaders: HTTPHeaders = []
    var parameters: Parameters = [String: Any]()
    
    init(
        commonHeaders: HTTPHeaders = [],
        parameters: Parameters = [String: Any](),
        parser: Parsable.Type = ParserService.self
    ) {
        self.commonHeaders = commonHeaders
        self.parameters = parameters
        self.parser = parser
    }
    
    func getDefaultLocations() async -> GenericResponse<Locations> {
        await withCheckedContinuation { continuation in
            AF.request(
                "https://apps.cochlear.limited/tht/locations.json",
                parameters: parameters,
                headers: commonHeaders,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { [weak self] response in
                guard let self = self else { return }
                switch(response.result) {
                    case let .success(data):
                        if let locations: Locations = self.parser.parse(data: data, to: Locations.self) {
                            continuation.resume(returning: (locations, nil))
                        } else {
                            continuation.resume(returning: (nil, NetworkErrors.parseError))
                        }
                    case .failure(_):
                        continuation.resume(returning: (nil, NetworkErrors.networkError))
                }
            }
        }
    }
}

enum NetworkErrors: Error {
    case networkError
    case parseError
}
