import XCTest
import MapKit
import CoreLocation
@testable import SydneyLocations

final class SelectLocationViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOnNextTapMethodCall() throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = SelectLocationDelegateMock()
        let viewModel = SelectLocationViewModel(
            selectedRegion: region,
            delegate: delegateMock
        )
        
        // act
        viewModel.onNextTap()
        
        // assert
        XCTAssert(delegateMock.isOnNextTapCalled == true, "onNextTap method not called")
    }
    
    func testOnCancelTapMethodCall() throws {
        
        // arrange
        let center = CLLocationCoordinate2DMake(MapPlace.Sydney.latitude, MapPlace.Sydney.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let delegateMock = SelectLocationDelegateMock()
        let viewModel = SelectLocationViewModel(
            selectedRegion: region,
            delegate: delegateMock
        )
        
        // act
        viewModel.onCancelTap()
        
        // assert
        XCTAssert(delegateMock.isOnCancelTapCalled == true, "onCancelTap method not called")
    }
}
