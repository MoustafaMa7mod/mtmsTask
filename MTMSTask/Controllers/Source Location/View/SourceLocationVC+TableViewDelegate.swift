//
//  SourceLocationVC+TableViewDelegate.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import Foundation
import UIKit


extension SourceLocationViewController: UITableViewDataSource , UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceLocationViewModel.getTotalNumberInList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as SourceLocationCell
        let data = self.sourceLocationViewModel.getDetailsItem(withIndex: indexPath.row)
        cell.config(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.sourceLocationViewModel.getDetailsItem(withIndex: indexPath.row)
        self.passData?(data)
        self.dismiss(animated: true, completion: nil)
    }
    
}
