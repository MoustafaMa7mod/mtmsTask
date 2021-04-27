//
//  DestinationLocationViewModel.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import Foundation
import GoogleMaps

class HomeViewModel {
    
    var driverDataArray = [DriverModel]()
    var currentLocation = CLLocation()
    
    func insertDestinationLocation(data: [String:Any] , withCompletion completion: @escaping(Bool) -> Void) {
        FirestoreReferenceManager.shared.insertInDB(collectionPath: CollectionPath.drivers, data: data) { insertData in
            completion(insertData)
        }
    }
    
    func getDriversData(currentLocation: CLLocation ,completion:@escaping(Bool) -> Void) {
        self.currentLocation = currentLocation
        FirestoreReferenceManager.shared.getData(collectionPath: CollectionPath.drivers) { data  in
            
            guard let data = data else {
                completion(false)
                return
            }
            do {
                let driverModel =  try JSONDecoder().decode(DriverModel.self, from:  JSONSerialization.data(withJSONObject: data))
                self.driverDataArray.append(driverModel)
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)

            }
            
        }
    }
    
    func getNearbyDreivers() -> [DriverModel]{
        var nerabyDriverArray = [DriverModel]()
        self.driverDataArray.forEach { driverLocation in
            // get location of drivers
            let location = CLLocation(latitude: driverLocation.latitude ?? 0.0 , longitude: driverLocation.longitude ?? 0.0)
            let distance = currentLocation.distance(from: location)
            
            // you get here distance in meter so 1 miles = 1609 meter
            if(distance <= 1609){
                nerabyDriverArray.append(driverLocation)
            }else{
                print("Driver not nearby from source location")
            }
            
        }
        
        return nerabyDriverArray
    }
    
    func formatLocationNameOfNearbyDrivers() -> String{
        let neabyDrivers = self.getNearbyDreivers()
        var locationName = ""
        neabyDrivers.forEach { driverData in
            locationName += driverData.name ?? "" + "-"
        }
        
        return locationName
    }
    
    
}
