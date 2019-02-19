//
//  DFTCreateTableViewCell.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
protocol DFTTableViewCellDelegate {
    func updateModel(cellModel : CellModel)
    func openLocation()
}

class DFTCreateTableViewCell: UITableViewCell {

    var cellModel : CellModel?
    var dataModel : DFTHeaderType?
     var delegate : DFTTableViewCellDelegate?
    var departments : [String]!
    var reviewers : [Reviewer] = [Reviewer]()
    let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(dismissPicker))
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var cellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ cellModel : CellModel) {
        self.cellModel = cellModel
        self.cellLabel.text = cellModel.labelName
        switch self.cellModel?.identifier {
        case "VendorRefNo":
            self.cellTextField?.text = self.dataModel?.vendorRefNumber ?? ""
        case "Department":
            let pickerView = UIPickerView()
            self.departments = ["Operations", "Capital Projects" , "Maintainence"]
            self.cellTextField?.text = self.dataModel?.department ?? ""
            self.cellTextField.inputView = pickerView
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.tag = 0
            self.cellTextField.inputAccessoryView = toolBar
        case "Reviewer":
            let pickerView = UIPickerView()
            
            self.reviewers.append(Reviewer(name: "DFT Reviewer", emailId: "dftrev@gmail.com", pId: "P000066"))
            self.reviewers.append(Reviewer(name: "Sammy Daniels", emailId: "sam.daniels@gmail.com", pId: "P99887"))
            self.reviewers.append(Reviewer(name: "John Ricthie", emailId: "ohn.ritchie@gmail.com", pId: "P679967"))
            self.reviewers.append(Reviewer(name: "George Pool", emailId: "george.pool@gmail.com", pId: "P12342"))
            self.cellTextField?.text = self.dataModel?.reviewerEmail ?? ""
            self.cellTextField.inputAccessoryView = toolBar
            self.cellTextField.inputView = pickerView
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.tag = 1
        default:
            print("")
        }

    }
    @objc func dismissPicker(){
        self.cellTextField.endEditing(true)
    }
}
extension DFTCreateTableViewCell : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.cellTextField.text = textField.text
        switch self.cellModel?.identifier {
        case "VendorRefNo":
            self.dataModel?.vendorRefNumber = textField.text
        case "Department":
            self.dataModel?.department = textField.text
        case "Reviewer":
            self.dataModel?.reviewerID = textField.text
        default:
            print("")
        }
        self.delegate?.updateModel(cellModel: self.cellModel!)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cellTextField.text = textField.text
        switch self.cellModel?.identifier {
        case "Location":
            self.delegate?.openLocation()
        default:
            print("")
        }
    }
}
extension DFTCreateTableViewCell : UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
        return self.departments.count
        }else {
            return self.reviewers.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return self.reviewers[row].emailId

        }else {
            return self.departments[row]
        }
    }
}
extension DFTCreateTableViewCell : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
        self.dataModel?.department = self.departments[row]
        self.cellTextField.text = self.dataModel?.department
        }
        else{
            self.dataModel?.reviewerEmail = self.reviewers[row].emailId
            self.cellTextField.text = self.dataModel?.reviewerEmail
        }
    }

}
