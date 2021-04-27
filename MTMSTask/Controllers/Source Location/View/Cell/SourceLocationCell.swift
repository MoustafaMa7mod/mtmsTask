//
//  SourceLocationCell.swift
//  MTMSTask
//
//  Created by Mostafa Mahmoud on 4/27/21.
//

import UIKit

class SourceLocationCell: UITableViewCell {

    
    @IBOutlet weak var sourceLocationName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ data: SourceLocationModel){
        self.sourceLocationName.text = data.name
    }
    
}
