//
//  DFTDateTimeTableViewCell.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import SAPOData

class DFTDateTimeTableViewCell: UITableViewCell {
    
    var cellModel : CellModel?
    var dataModel : DFTHeaderType?
    let dateFormatter = DateFormatter()
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    dateFormatter.dateFormat = "dd MMM yyyy"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setData(_ cellModel : CellModel) {
        self.cellModel = cellModel
        self.setInputViews()
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(dismissPicker))
        toolBar.backgroundColor = UIColor(hexString: "445E75")

        self.textField2.inputAccessoryView = toolBar
        self.textField1.inputAccessoryView = toolBar

        switch cellModel.identifier {
        case "StartDetails":
            self.label1.text = "Start Date *"
            self.label2.text = "Start Time"
            
        case "EndDetails":
            self.label1.text = "End Date *"
            self.label2.text = "End Time"


        default:
            print("Invalid Cell identifier")
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

        switch cellModel?.identifier {
        case "StartDetails":
            self.dataModel?.startDate = LocalDateTime.from(utc: sender.date)
            let dateTimeString : String = LocalDateTime.from(utc: sender.date, in: TimeZone.current).toString()
            self.textField1.text =  convertTimeStamp(dateTimeString: dateTimeString)
        case "EndDetails":
            self.dataModel?.endDate = LocalDateTime.from(utc: sender.date)
            let dateTimeString : String = LocalDateTime.from(utc: sender.date, in: TimeZone.current).toString()
            self.textField1.text =  convertTimeStamp(dateTimeString: dateTimeString)
        default:
            print("")
        }
        self.reloadInputViews()
    }
    @objc func handleTimeChange(sender: UIDatePicker){
        switch cellModel?.identifier {
        case "StartDetails":
            self.dataModel?.startTime = LocalTime.from(utc: sender.date)
            self.textField2.text =  LocalTime.from(utc: sender.date, in: TimeZone.current).toString()
        case "EndDetails":
            self.dataModel?.endTime = LocalTime.from(utc: sender.date, in: TimeZone.current)
            self.textField2.text =  LocalTime.from(utc: sender.date).toString()
        default:
            print("")
        }
        self.reloadInputViews()
    }
}
extension DFTDateTimeTableViewCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    @objc func dismissPicker(){
        if self.textField1.isEditing && cellModel?.identifier == "StartDetails"{
            if self.dataModel?.startDate == nil {
                self.dataModel?.startDate =  LocalDateTime.from(utc : Date())
            }

        }
     self.endEditing(true)
    }
}
