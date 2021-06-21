//
//  MapVehiclesViewController.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVehiclesViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var vehicleToShow: Vehicle!
     var locationManager = CLLocationManager()
    lazy var viewModel: MapViewModel = {
        return MapViewModel()
    }()
    
    @IBOutlet weak var mapGoogleView: GMSMapView!
    @IBOutlet weak var closeButton: UIButton!
    
    convenience init(vehicle: Vehicle){
        self.init()
        self.vehicleToShow = vehicle
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocation()
        viewModel.initFetch(vehicle: self.vehicleToShow)
        setupMap()
    }

    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func initLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapGoogleView.isMyLocationEnabled = true
            mapGoogleView.settings.myLocationButton = true
        default: break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapGoogleView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: viewModel.getLatitude(), longitude: viewModel.getLongitude()), zoom: 11, bearing: 0, viewingAngle: 0)
    }
    
    func setupMap(){
        let position = CLLocationCoordinate2DMake(viewModel.getLatitude(), viewModel.getLongitude())
        let marker = GMSMarker(position: position)
        marker.title = "\(viewModel.getNickname())"
        marker.snippet = "\(("LICENSE".localized(tableName: "Strings"))): \(viewModel.getLicense())"
        marker.map = self.mapGoogleView
        mapGoogleView.selectedMarker = marker
    }
}
