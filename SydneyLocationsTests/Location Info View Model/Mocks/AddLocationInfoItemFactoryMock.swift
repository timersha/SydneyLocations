import Foundation
@testable import SydneyLocations

enum AddLocationInfoItemFactoryMock: AddLocationInfoItemFactoryProtocol {
    
    static var isMakeItemsCalled: Bool = false
    static var makeItemsResult = [any SydneyLocations.ViewGeneratable]()
    
    static func makeItems(
        delegate: any SydneyLocations.AddLocationInfoItemDelegate
    ) -> [any SydneyLocations.ViewGeneratable] {
        isMakeItemsCalled = true
        return makeItemsResult
    }
}
