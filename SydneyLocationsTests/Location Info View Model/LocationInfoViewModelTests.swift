import XCTest
@testable import SydneyLocations

final class LocationInfoViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnAppearMethodCall() throws {

        // arrange
        let model = LocationInfo(
            id: MapPlace.BondiBeach.id,
            name: MapPlace.BondiBeach.name,
            latitude: MapPlace.BondiBeach.latitude,
            longitude: MapPlace.BondiBeach.longitude,
            description: MapPlace.BondiBeach.description ?? ""
        )
        let delegateMock = LocationInfoViewModelDelegateMock()
        let factoryMock = LocationInfoItemsFactoryMock.self
        let editFactoryMock = AddLocationInfoItemFactoryMock.self
        
        let viewModel = LocationInfoViewModel(
            model: model,
            delegate: delegateMock,
            factory: factoryMock,
            editFactory: editFactoryMock
        )
        
        // act
        viewModel.onEditTap()
        
        // assert
        XCTAssert(editFactoryMock.isMakeItemsCalled == true, "makeItems method not called")
    }
    
    func testOnSaveTapMethodCall() throws {
        
        // arrange
        let model = LocationInfo(
            id: MapPlace.BondiBeach.id,
            name: MapPlace.BondiBeach.name,
            latitude: MapPlace.BondiBeach.latitude,
            longitude: MapPlace.BondiBeach.longitude,
            description: MapPlace.BondiBeach.description ?? ""
        )
        let delegateMock = LocationInfoViewModelDelegateMock()
        let factoryMock = LocationInfoItemsFactoryMock.self
        let editFactoryMock = AddLocationInfoItemFactoryMock.self
        
        let viewModel = LocationInfoViewModel(
            model: model,
            delegate: delegateMock,
            factory: factoryMock,
            editFactory: editFactoryMock
        )
        
        // act
        viewModel.onSaveTap()
        
        // assert
        XCTAssert(delegateMock.isOnSaveTapCalled == true, "onSaveTap method not called")
        XCTAssert(factoryMock.isMakeInofItemsCalled == true, "makeInofItems method not called")
    }
}
