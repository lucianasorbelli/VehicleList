//
//  VehicleOverviewTests.swift
//  VehicleOverviewTests
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import XCTest
import CoreLocation
@testable import VehicleOverview

class VehicleOverviewTests: XCTestCase {
    
    var vehicles = [Vehicle]()
    var viewModel = VehicleControllerViewModel()
    
    override func setUp() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.path(forResource: "MockVehicleListResponse", ofType: "json")!
        let fileUrl = URL(fileURLWithPath: path)
        let jsonData = (try? Data(contentsOf: fileUrl))!
        let decoder = JSONDecoder()
        let json = try? decoder.decode([Vehicle].self, from: jsonData)
        vehicles = json!
        viewModel.initFetch(dataJson: vehicles)
    }
    
    override func setUpWithError() throws {
        setUp()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_Alphabetic_order() throws {
        viewModel.sortAlphabetic()
        XCTAssert((viewModel.dataJsonV as Any) is [Vehicle])
    }
    
    func test_vehicle_nickname() {
        let vehicle = viewModel.dataJsonV?.first
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle!)
        XCTAssertEqual(vehicle?.nickname, vm.getNickname())
    }
    
    func test_vehicle_model(){
        let vehicle = viewModel.dataJsonV?.first
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle!)
        XCTAssertEqual(vehicle?.model, vm.getModel())
    }
    
    func test_vehicle_brand(){
        let vehicle = viewModel.dataJsonV?.first
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle!)
        XCTAssertEqual(vehicle?.brand, vm.getBrand())
    }
    
    func test_vehicle_license(){
        let vehicle = viewModel.dataJsonV?.first
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle!)
        XCTAssertEqual(vehicle?.licensePlate, vm.getLicense())
    }
    
    func test_async_api_call_fetch_vehicles(){
        let apiClient = APIClient()
        let exp = expectation(description: "ApiClient runs fetchVehicles api call")
        apiClient.fetchVehicles() { (dataJson) in
            XCTAssertNotNil(dataJson)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3){ error in
            if let err = error {
                XCTFail("waitForExpectationsWithTimeout error: \(err)")
            }
        }
    }
    
    func test_get_distance_vehicle_far(){
        let lastPosition = LastPosition(lat: -34.5472104 , lng: -58.4418859 )
        let vehicle = Vehicle(id: 12, licensePlate: "AD 138 HR", brand: "Audi", model: "Model1", nickname: "LuliCar", lastPosition: lastPosition)
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle)
        
        let currentLocation =  CLLocation(latitude: -34.5863676 , longitude: -58.5108578)
        XCTAssertEqual(vm.getDistanceFrom(currentLocation: currentLocation ), "7 kms.")
    }
    
    func test_get_distance_vehicle_short(){
        let lastPosition = LastPosition(lat: -34.5472104 , lng: -58.4418859 )
        let vehicle = Vehicle(id: 12, licensePlate: "AD 138 HR", brand: "Audi", model: "Model1", nickname: "LuliCar", lastPosition: lastPosition)
        let vm = MapViewModel()
        vm.initFetch(vehicle: vehicle)
        
        let currentLocation =  CLLocation(latitude: -34.5472104 , longitude: -58.4418859)
        XCTAssertEqual(vm.getDistanceFrom(currentLocation: currentLocation ), "0 kms.")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
