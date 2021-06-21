//
//  InitialViewControllerExtension.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 19/06/2021.
//
import UIKit
import Foundation

extension InitialViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.dataJsonV?.count ?? Int()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if let vehicles = viewModel.dataJsonV {
            self.goToMapView(vehicle: vehicles[row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let currentDist = self.locationManager.location
        let cell = vehiclesTableView.dequeueReusableCell(withIdentifier: "VehicleTableViewCell", for: indexPath) as! VehicleTableViewCell
        if let vehicleOk = self.viewModel.dataJsonV?[row]{
            let vm = MapViewModel()
            let distance = vm.getDistanceFrom(currentLocation: currentDist)
            vm.initFetch(vehicle: vehicleOk)
            cell.nicknameLabel.text = vm.getNickname()
            cell.licenseLabel.text = vm.getLicense()
            cell.brandAndModelLabel.text = "\(vm.getBrand()), \(vm.getModel())"
            (distance != String()) ? (cell.distanceMtrs.setTitle(distance, for: .normal)) : (cell.distanceMtrs.isHidden = true)
        }
        return cell
    }
}
