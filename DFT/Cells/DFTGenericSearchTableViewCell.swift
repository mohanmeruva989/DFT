//
//  DFTGenericSearchTableViewCell.swift
//  DFT
//
//  Created by Mohan on 27/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTGenericSearchTableViewCell: UITableViewCell {

    @IBOutlet var label1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setData(currentObj : TableViewDisplayable) {
        self.label1.text = currentObj.label1
    }

}
