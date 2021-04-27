//
//  HomeVC+SearchPlaces.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import Foundation
import GooglePlaces

extension HomeViewController: GMSAutocompleteViewControllerDelegate{
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.showLocationAndMarkerInMap(place.coordinate.latitude, place.coordinate.longitude)
        self.getAddressFromLocation(loc: CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude))
        dismiss(animated: true , completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}





