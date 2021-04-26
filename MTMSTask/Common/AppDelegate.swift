//
//  AppDelegate.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        configGoogleMap()
        
        return true
    }
    
    
    private func configGoogleMap(){
        GMSServices.provideAPIKey(GoogleKey.key)
        GMSPlacesClient.provideAPIKey(GoogleKey.key)

    }


}

