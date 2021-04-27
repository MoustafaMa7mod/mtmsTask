//
//  HomeVC+Delegate.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import Foundation
import GoogleMaps
import GooglePlaces

extension HomeViewController: CLLocationManagerDelegate , GMSMapViewDelegate{
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Check accuracy authorization
        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.clear()
        guard let userLocation = locations.last else {
            return
        }
        self.showLocationAndMarkerInMap(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        selectedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: center)
        marker.map = self.mapView
    }
    
    func showLocationAndMarkerInMap(_ lat: CLLocationDegrees , _ long: CLLocationDegrees){
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        self.mapView.camera = camera
        selectedLocation =  CLLocation(latitude: lat, longitude: long)
        let marker = GMSMarker(position: center)
        marker.map = self.mapView

    }
    
    
    func getAddressFromLocation(loc: CLLocation){
        let ceo: CLGeocoder = CLGeocoder()
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil){
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let placemark = placemarks! as [CLPlacemark]
                                        if placemark.count > 0 {
                                            let placemark = placemarks![0]
                                            print(placemark)
                                            let data: [String:Any] = ["name": placemark.name ?? "" , "latitude": loc.coordinate.latitude , "longitude" : loc.coordinate.longitude]
                                            self.homeViewModel.insertDestinationLocation(data: data) { done in
                                                if done {
                                                    print("data insert succeesfully")
                                                }else{
                                                    print("error when insert data")
                                                }
                                                
                                            }
                                        }
                                    })
       
        
    }
}

extension HomeViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == yourLocationTextField {
            let viewController = SourceLocationViewController.instantiate()
            viewController.passData = { [weak self] sourceLocationData in
                self?.yourLocationTextField.text = sourceLocationData.name ?? ""
                self?.showLocationAndMarkerInMap(sourceLocationData.latitude ?? 0.0, sourceLocationData.longitude ?? 0.0)
                
            }
            self.present(viewController , animated: true)
            return false
        }else{
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            // Specify the place data types to return.
            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.all.rawValue))
            autocompleteController.placeFields = fields
            // Specify a filter.
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            filter.country = "EG"
            autocompleteController.autocompleteFilter = filter
            // Display the autocomplete view controller.
            present(autocompleteController, animated: true, completion: nil)
            return false
        }
    }

    
}





