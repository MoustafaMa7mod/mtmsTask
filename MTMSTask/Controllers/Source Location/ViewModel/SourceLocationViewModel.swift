//
//  SourceLocationViewModel.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import UIKit

class SourceLocationViewModel: NSObject {

    var sourceLocationArray = [SourceLocationModel]()
    var sourceLocationArrayFilter = [SourceLocationModel]()
    
    func getData(completion:@escaping(Bool) -> Void) {
        FirestoreReferenceManager.shared.getData(collectionPath: CollectionPath.source) { data  in
            
            guard let data = data else {
                completion(false)
                return
            }
            do {
                let sourceLocationModel =  try JSONDecoder().decode(SourceLocationModel.self, from:  JSONSerialization.data(withJSONObject: data))
                self.sourceLocationArray.append(sourceLocationModel)
                self.sourceLocationArrayFilter.append(sourceLocationModel)
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)

            }
            
        }
    }
    
    func filterData(_ name: String) {
        self.sourceLocationArrayFilter.removeAll()
        if name.count != 0 {
            for location in self.sourceLocationArray {
                if let locationName = location.name {
                    let range = locationName.lowercased().range(of: name.lowercased(), options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.sourceLocationArrayFilter.append(location)
                    }
                }
                
            }
        }else{
            for location in self.sourceLocationArray {
                self.sourceLocationArrayFilter.append(location)
            }
        }
    }
    
    func getTotalNumberInList() -> Int {
        return self.sourceLocationArrayFilter.count
    }
    
    func getDetailsItem(withIndex index: Int) -> SourceLocationModel {
        return self.sourceLocationArrayFilter[index]
    }
    
}
