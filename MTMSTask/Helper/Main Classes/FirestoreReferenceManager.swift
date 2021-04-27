//
//  FirestoreReferenceManager.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirestoreReferenceManager{
    static let shared = FirestoreReferenceManager()

    
    private var settings = FirestoreSettings()
    private let db = Firestore.firestore()
    
    private init() {
        settings.isPersistenceEnabled = true
        db.settings = settings
    }
    
    func insertInDB(collectionPath: String ,data: [String: Any], completion: @escaping (Bool) -> Void ) {
        let root = db.collection(collectionPath)
        let docId = root.document().documentID
        db.collection(collectionPath).document(docId).setData(data, merge: true) { error in
            if let err = error {
                print(err)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func getData(collectionPath: String,completion: @escaping ([String: Any]?) -> Void){
        db.collection(collectionPath).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                for document in querySnapshot!.documents {
                    completion(document.data())
                }
            }
        }
    }
    
}
