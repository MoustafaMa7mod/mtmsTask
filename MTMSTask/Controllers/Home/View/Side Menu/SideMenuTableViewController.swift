//
//  SideMenuTableViewController.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/26/21.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    // MARK:- varaibles
    let items = ["Home" , "Locations" ,"Setting" , "Logout"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    private func configTableView(){
        tableView.backgroundColor = .lightGray
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .lightGray
        return cell
        
    }


}
