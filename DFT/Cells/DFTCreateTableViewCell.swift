//
//  DFTCreateTableViewCell.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTCreateTableViewCell: UITableViewCell {

    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ cellModel : CellModel) {
        self.cellLabel.text = cellModel.labelName
        
    }
}
