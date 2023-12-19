import XCTest
@testable import SydneyLocations

final class AddLocationInfoViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOnSaveTapMethodCall() throws {
        
        // arrange
        let delegateMock = AddLocationInfoDelegateMock()
        let factoryMock = AddLocationInfoItemFactoryMock.self
        
        let viewModel = AddLocationInfoViewModel(
            name: "name",
            description: "description",
            delegate: delegateMock,
            factory: factoryMock
        )
        
        // act
        viewModel.onSaveTap()
        
        // assert
        XCTAssert(delegateMock.isOnSaveTapCalled == true, "onSaveTap method not called")
    }
    
    func testOnSaveTapMethodNotCalled() throws {
        
        // arrange
        let delegateMock = AddLocationInfoDelegateMock()
        let factoryMock = AddLocationInfoItemFactoryMock.self
        
        let viewModel = AddLocationInfoViewModel(
            delegate: delegateMock,
            factory: factoryMock
        )
        
        // act
        viewModel.onSaveTap()
        
        // assert
        XCTAssert(delegateMock.isOnSaveTapCalled == false, "onSaveTap method not called")
    }
}
