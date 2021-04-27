//
//  SourceLocationViewController.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import UIKit

class SourceLocationViewController: UIViewController {

    
    // MARK: - outlets
    @IBOutlet weak var yourLocationTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - variables
    var sourceLocationViewModel = SourceLocationViewModel()
    var passData: ((SourceLocationModel)->())?
    
    // MARK: - main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTextField()
        loadData()
    }

    class func instantiate() -> SourceLocationViewController {
        return UIStoryboard(name: "SourceLocation", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! SourceLocationViewController
    }
    // MARK: - setup table view
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(cellClass: SourceLocationCell.self)
    }
    
    // MARK: - setup text filed
    private func setupTextField() {
        yourLocationTextField.becomeFirstResponder()
        yourLocationTextField.delegate = self
        yourLocationTextField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }
    
    private func loadData(){
        sourceLocationViewModel.getData { [weak self] loadDataDone in
            if loadDataDone {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - action
    @IBAction func backToMapPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SourceLocationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        yourLocationTextField.resignFirstResponder()
        return true
    }
    @objc func searchRecords(_ textField: UITextField) {
        self.sourceLocationViewModel.filterData(textField.text ?? "")
        self.tableView.reloadData()
    }
}
