//
//  VehicleControllerViewModel.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import Foundation

class VehicleControllerViewModel {
    
    var dataJsonV: [Vehicle]?
    
    func initFetch(dataJson: [Vehicle]) {
        self.dataJsonV = dataJson
    }
    func sortAlphabetic(){
        self.dataJsonV?.sort { (elem1 , elem2) -> Bool in
            return (elem1.nickname ?? String() <= elem2.nickname ?? String())
        }
    }
    func fetchVehicles(serviceCompleted: @escaping ([Vehicle]?) -> Void){
        APIClient().fetchVehicles() { (dataJson) in
            self.dataJsonV = dataJson
            serviceCompleted(dataJson)
        }
    }
}
