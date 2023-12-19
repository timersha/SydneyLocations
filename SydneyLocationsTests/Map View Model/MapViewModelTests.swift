import XCTest
import MapKit
import CoreLocation
import Combine
@testable import SydneyLocations

final class MapViewModelTests: XCTestCase {
    
    private var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        MapItemsFactoryMock.isMakeCenterCalled = false
        MapItemsFactoryMock.isMakeRegionCalled = false
        MapItemsFactoryMock.isMakeMapItemsCalled = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShowListMethodCall() throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = MapViewModelDelegateMock()
        let coreDataServiceMock = CoreDataServiceMock()
        let factoryMock = MapItemsFactoryMock.self
        
        let viewModel = MapViewModel(
            region: region,
            delegate: delegateMock,
            coreDataService: coreDataServiceMock,
            factory: factoryMock
        )
        
        // act
        viewModel.showList()
        
        // assert
        XCTAssert(delegateMock.isShowLocationsListCalled == true, "showLocationsList method not called")
    }
    
    func testCreateLocationMethodCall() async throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = MapViewModelDelegateMock()
        let coreDataServiceMock = CoreDataServiceMock()
        let factoryMock = MapItemsFactoryMock.self
        
        let viewModel = MapViewModel(
            region: region,
            delegate: delegateMock,
            coreDataService: coreDataServiceMock,
            factory: factoryMock
        )
        
        // act
        let task = Task {
            viewModel.createLocation()
        }
        await task.value
        
        // assert
        XCTAssert(delegateMock.isCreateLocationCalled == true, "createLocation method not called")
    }
    
    func testOnAppearMethodCall() async throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = MapViewModelDelegateMock()
        let coreDataServiceMock = CoreDataServiceMock()
        let factoryMock = MapItemsFactoryMock.self
        
        let viewModel = MapViewModel(
            region: region,
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
        XCTAssert(factoryMock.isMakeMapItemsCalled == true, "makeMapItems method not called")
    }
    
    func testDidTapAnnotationMethodCall() throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = MapViewModelDelegateMock()
        let coreDataServiceMock = CoreDataServiceMock()
        let factoryMock = MapItemsFactoryMock.self
        
        let viewModel = MapViewModel(
            region: region,
            delegate: delegateMock,
            coreDataService: coreDataServiceMock,
            factory: factoryMock
        )
        
        // act
        viewModel.didTapAnnotation(place: .Sydney)
        
        // assert
        XCTAssert(delegateMock.isShowLocationDetails == true, "showLocationDetails method not called")
    }
}
