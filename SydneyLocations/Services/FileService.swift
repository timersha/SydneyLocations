import Foundation

private extension String {
    static let locations = "locations"
    static let json = "json"
}

protocol FileServiceProtocol {
    static var locationsFileUrl: URL? { get }

    static func makeUrl(forResourse name: String, ofType ext: String) -> URL?
    static func getLocationsData() -> Data?
}

enum FileService {}

// MARK: - FileServiceProtocol

extension FileService: FileServiceProtocol {

    static var locationsFileUrl: URL? {
        makeUrl(forResourse: .locations, ofType: .json)
    }
    
    static func makeUrl(forResourse name: String, ofType ext: String) -> URL? {
        Bundle.main.url(forResource: name, withExtension: ext)
    }
    
    static func getLocationsData() -> Data? {
        guard let locationsUrl: URL = locationsFileUrl,
              let locationsData: Data = try? Data(contentsOf: locationsUrl) else {
            return nil
        }
        return locationsData
    }
}
