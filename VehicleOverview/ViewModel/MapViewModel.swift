//
//  MapViewModel.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import Foundation
import CoreLocation

class MapViewModel {
    
    var singleVehicle: Vehicle?
    
    func initFetch(vehicle: Vehicle){
        self.singleVehicle = vehicle
    }
    func getLatitude() -> Double {
        return self.singleVehicle?.lastPosition?.lat ?? Double()
    }
    
    func getLongitude() -> Double {
        return singleVehicle?.lastPosition?.lng ?? Double()
    }
    
    func getNickname() -> String? {
        return singleVehicle?.nickname
    }
    
    func getLicense() -> String {
        return singleVehicle?.licensePlate ?? String()
    }
    
    func getModel() -> String{
        return singleVehicle?.model ?? String()
    }
    
    func getBrand() -> String{
        return  singleVehicle?.brand ?? String()
    }
    func getDistanceFrom(currentLocation: CLLocation?) -> String? {
        let vehicleLocation = CLLocation(latitude: self.getLatitude(), longitude: self.getLongitude())
        let distance = Int(currentLocation?.distance(from: vehicleLocation) ?? Double())/1000
        return "\(String(distance)) kms."
    }
}
