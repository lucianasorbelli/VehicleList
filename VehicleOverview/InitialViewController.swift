//
//  InitialViewController.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import UIKit
import CoreLocation

class InitialViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {

    lazy var viewModel: VehicleControllerViewModel = {
        return VehicleControllerViewModel()
    }()
    @IBOutlet weak var vehiclesTableView: UITableView!
    lazy var refreshControl = UIRefreshControl()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        initLocation()
        fetchVehicles()
        configRefresh()
        configNavigationBar()
    }
    @objc func refresh(_ sender: AnyObject) {
        self.fetchVehicles()
    }
    
    func initLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func configNavigationBar() {
        self.navigationItem.title = ("NAV_TITLE".localized(tableName: "Strings"))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
    }
    
    func setDelegates(){
        self.locationManager.delegate = self
        self.vehiclesTableView.delegate = self
        self.vehiclesTableView.dataSource = self
        self.vehiclesTableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleTableViewCell")
    }
    func configRefresh(){
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.vehiclesTableView.addSubview(refreshControl)
    }
    func fetchVehicles(){
        DispatchQueue.main.async {
            self.viewModel.fetchVehicles(){ (vehicles) in
                self.viewModel.sortAlphabetic()
                self.vehiclesTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func goToMapView(vehicle: Vehicle){
        let mapVC = MapVehiclesViewController(vehicle: vehicle )
        self.navigationController?.present(mapVC, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.vehiclesTableView.reloadData()
        }
    }
}
