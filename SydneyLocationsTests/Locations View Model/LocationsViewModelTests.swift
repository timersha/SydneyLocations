import XCTest
import Combine
@testable import SydneyLocations

final class LocationsViewModelTests: XCTestCase {
    
    private var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOnAppearMethodCall() async throws {
        
        // arrange
        let coreDataServiceMock = CoreDataServiceMock()
        let delegateMock = LocationsViewItemsDelegateMock()
        let factoryMock = LocationsItemsFactoryMock.self
        let viewModel = LocationsViewModel(
            delegate: delegateMock,
            coreDataService: coreDataServiceMock,
            factory: factoryMock
        )
        
        let onAppearCallExpectation = XCTestExpectation()
        
        coreDataServiceMock.$isGetLocationsCalled
            .sink { value in
                debugPrint("value: \(value)")
                if value {
                    onAppearCallExpectation.fulfill()
                }
            }.store(in: &cancellable)
        
        // act
        let task = Task {
            viewModel.onAppear()
        }
        await task.value
        
        // assert
        await fulfillment(of: [onAppearCallExpectation], timeout: 2)
    }
}
