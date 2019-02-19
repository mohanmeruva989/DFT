//
//  DFTDateTimeTableViewCell.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTDateTimeTableViewCell: UITableViewCell {
    
    var cellModel : CellModel?
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
        self.cellModel = cellModel
        self.setInputViews()
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
        self.textField1.placeholder = "--Select--"
        self.textField2.placeholder = "--Select--"
    }
    func setInputViews() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDateChange(sender:)), for: UIControl.Event.allEvents)
        self.textField1.inputView = datePickerView

        let timePickerView = UIDatePicker()
        timePickerView.datePickerMode = .time
        timePickerView.addTarget(self, action: #selector(handleTimeChange(sender:)), for: UIControl.Event.allEvents)
        self.textField2.inputView = timePickerView
    }
    @objc func handleDateChange(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.textField1.text = dateFormatter.string(from: sender.date)
        self.reloadInputViews()
    }
    @objc func handleTimeChange(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        self.textField2.text = dateFormatter.string(from: sender.date)
        self.reloadInputViews()
    }
}
extension DFTDateTimeTableViewCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.cellModel?.inputValue = textField.text
    }
}
