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
    
    // MARK: - variables

    var locationManager = CLLocationManager()
    var selectedLocation: CLLocation? = CLLocation()
    var sideMenu: SideMenuNavigationController?
    
    // MARK: - main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLocationManager()
        self.configMapView()
        self.configSideMenu()
//        self.updateMenus()
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
        sideMenu = SideMenuNavigationController(rootViewController: UIViewController())
        sideMenu?.leftSide = true
    }

    
    @IBAction func showSideMenu(_ sender: Any) {
        present(sideMenu!, animated: true, completion: nil)
    }
    
    
    
    
}
