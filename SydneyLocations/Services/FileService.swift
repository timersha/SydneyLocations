import Foundation

private extension String {
    static let locations = "locations"
    static let json = "json"
}

protocol FileServiceProtocol {
    static var defaultLocationsUrl: URL? { get }

    static func makeUrl(forResourse name: String, ofType ext: String) -> URL?
    static func defaultLocationsData() -> Data?
}

enum FileService {}

// MARK: - FileServiceProtocol

extension FileService: FileServiceProtocol {

    static var defaultLocationsUrl: URL? {
        makeUrl(forResourse: .locations, ofType: .json)
    }

    static func defaultLocationsData() -> Data? {
        guard let locationsUrl: URL = defaultLocationsUrl,
              let locationsData: Data = try? Data(contentsOf: locationsUrl) else {
            return nil
        }
        return locationsData
    }

    static func makeUrl(forResourse name: String, ofType ext: String) -> URL? {
        Bundle.main.url(forResource: name, withExtension: ext)
    }
}
