//
//  ViewController.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - variables

    var locationManager = CLLocationManager()
    var selectedLocation: CLLocation? = CLLocation()

    
    // MARK: - main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLocationManager()
        self.configMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configLocationManager()
        self.configMapView()
        
    }
    
    
    // MARK:- config map view and loaction manager
    private func configLocationManager(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func configMapView(){
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
    }
    



}

