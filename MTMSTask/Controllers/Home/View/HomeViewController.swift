//
//  ViewController.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit
import GoogleMaps
import SideMenu

class HomeViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var yourLocationTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!

    // MARK: - variables
    var locationManager = CLLocationManager()
    var selectedLocation: CLLocation? = CLLocation()
    var sideMenu: SideMenuNavigationController?
    var homeViewModel = HomeViewModel()
    
    // MARK: - main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLocationManager()
        self.configMapView()
        self.configSideMenu()
    }
    
        
    // MARK:- config loaction manager
    private func configLocationManager(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    // MARK:- config map view
    private func configMapView(){
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
    }
    
    // MARK:- config side menu

    private func configSideMenu(){
        sideMenu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        
    }

    
    @IBAction func showSideMenu(_ sender: Any) {
        present(sideMenu!, animated: true, completion: nil)
    }
    
    @IBAction func makeRequestRd(_ sender: Any) {
        guard let curerntLocation = selectedLocation else {
            return
        }
        
        self.homeViewModel.getDriversData(currentLocation: curerntLocation , completion: { [weak self] loadData in
            if loadData {
                DispatchQueue.main.async {
                    self?.showAlertWithNearbyDerivers()
                }
                
            }
        })
        
    }
    
    private func showAlertWithNearbyDerivers(){
        let nearbyLocation = self.homeViewModel.formatLocationNameOfNearbyDrivers()
        print(nearbyLocation)
        let aletController = UIAlertController(title: "Nearby Drivers", message: nearbyLocation, preferredStyle: .alert)
        aletController.addAction(UIAlertAction(title: "OK" , style: .default, handler: nil))
        
        if !(self.navigationController?.visibleViewController?.isKind(of: UIAlertController.self))! {
            self.present(aletController, animated: true, completion: nil)
        }
    }
    
    
    
}
