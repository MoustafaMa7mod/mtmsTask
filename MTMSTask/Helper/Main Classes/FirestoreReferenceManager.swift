//
//  FirestoreReferenceManager.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit
import Firebase
import FirebaseFirestore
struct CollectionPath {
    static let source = "Source"
    static let destinationLocation = "destinationLocation"
}


class FirestoreReferenceManager{
    var settings = FirestoreSettings()
    let db = Firestore.firestore()
    let shared = FirestoreReferenceManager()
    
    func insertInDB(collectionPath: String ,data: [String: Any], documentName: String?, errorCompletion: @escaping () -> () = {  }, successCompletion: @escaping (_ docID: String) -> () = {_ in  }) {
        let root = db.collection(collectionPath)
        let docId = root.document().documentID
        var document = String()
        if documentName == nil {
            document = docId
        }else{
            document = documentName ?? ""
        }
        db.collection(collectionPath).document(document).setData(data, merge: true) { error in
            if let err = error {
                print(err)
                errorCompletion()
            } else {
                successCompletion(document)
            }
        }
    }
    
    func getData(collectionPath: String,completion: @escaping ([String: Any] , Bool) -> Void){
        db.collection(collectionPath).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([:] , false)
            } else {
                for document in querySnapshot!.documents {
                    completion(document.data() , true)
                }
            }
        }
    }
    
}
