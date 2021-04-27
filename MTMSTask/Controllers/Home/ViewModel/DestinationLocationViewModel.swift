//
//  DestinationLocationViewModel.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import Foundation

class DestinationLocationViewModel {
    
    func insertDestinationLocation(data: [String:Any] , withCompletion completion: @escaping(Bool) -> Void) {
        FirestoreReferenceManager.shared.insertInDB(collectionPath: CollectionPath.destination, data: data) { insertData in
            completion(insertData)
        }
    }
}
