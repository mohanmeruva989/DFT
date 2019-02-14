//
//  DFTDateTimeTableViewCell.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTDateTimeTableViewCell: UITableViewCell {

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ cellModel : CellModel) {
        switch cellModel.identifier {
        case "StartDetails":
            self.label1.text = "Start Date"
            self.label2.text = "End Time"
        case "EndDetails":
            self.label1.text = "End Date"
            self.label2.text = "End Time"


        default:
            print("Invalind Cell identifier")
        }
    }
}
