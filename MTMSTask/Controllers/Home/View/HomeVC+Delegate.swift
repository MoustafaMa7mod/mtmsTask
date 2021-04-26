//
//  HomeVC+Delegate.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import Foundation
import GoogleMaps

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
        print("Latitude :- \(userLocation.coordinate.latitude)")
        print("Longitude :-\(userLocation.coordinate.longitude)")
        self.showLocationAndMarkerInMap(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
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
    
    
//    func getAddressFromLocation(loc: CLLocation, completion: @escaping (LocationModel)->Void){
//        let ceo: CLGeocoder = CLGeocoder()
//        ceo.reverseGeocodeLocation(loc, completionHandler:
//                                    {(placemarks, error) in
//                                        if (error != nil){
//                                            print("reverse geodcode fail: \(error!.localizedDescription)")
//                                        }
//                                        let placemark = placemarks! as [CLPlacemark]
//                                        if placemark.count > 0 {
//                                            let placemark = placemarks![0]
//                                            let locationModel = LocationModel(lat: loc.coordinate.latitude, long: loc.coordinate.longitude, locationInfo: placemark)
//                                            completion(locationModel)
//                                        }
//                                    })
//       
//        
//    }
    
    
    
    
    
}


