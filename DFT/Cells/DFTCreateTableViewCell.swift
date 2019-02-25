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
    var sesApprover : [String]?
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
            self.departments = ["", "Operations", "Capital Projects" , "Maintainence"]
            self.cellTextField?.text = self.dataModel?.department ?? ""
            self.cellTextField.inputView = pickerView
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.tag = 0
            self.cellTextField.inputAccessoryView = toolBar
        case "Reviewer":
            let pickerView = UIPickerView()
            if self.reviewers.count == 0 {
            self.reviewers.append(Reviewer(name: "", emailId: "", pId: ""))
            self.reviewers.append(Reviewer(name: "DFT Reviewer", emailId: "dftrev@gmail.com", pId: "P000066"))
            self.reviewers.append(Reviewer(name: "Sammy Daniels", emailId: "sam.daniels@gmail.com", pId: "P99887"))
            self.reviewers.append(Reviewer(name: "John Ricthie", emailId: "john.ritchie@gmail.com", pId: "P679967"))
            self.reviewers.append(Reviewer(name: "George Pool", emailId: "george.pool@gmail.com", pId: "P12342"))
            }
            self.cellTextField?.text = self.dataModel?.reviewerEmail ?? ""
            self.cellTextField.inputAccessoryView = toolBar
            self.cellTextField.inputView = pickerView
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.tag = 1
        case "Location" :
            print("")
            var location : String = ""
            
            if self.dataModel!.field == "" || self.dataModel!.field == nil{
                self.cellTextField.text = location
                self.dataModel?.location = location
                break
            }
            location = self.dataModel!.field!
            
            if  ""  == self.dataModel!.facility || self.dataModel!.field == nil{
                self.cellTextField.text = location
                self.dataModel?.location = location
                break
            }
            location = location + "/" + self.dataModel!.facility!

            if ""  == self.dataModel!.wellPad || self.dataModel!.field == nil {
                self.cellTextField.text = location
                self.dataModel?.location = location
                break
            }
            location = location + "/" + self.dataModel!.wellPad!

            if ""  == self.dataModel!.well  || self.dataModel!.field == nil{
                self.cellTextField.text = location
                self.dataModel?.location = location
                break
            }
            location = location + "/" + self.dataModel!.well!
            self.dataModel?.location = location
            self.cellTextField.text = location
            return

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
        default:
            print("")
        }
        self.delegate?.updateModel(cellModel: self.cellModel!)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cellTextField.text = textField.text
        switch self.cellModel?.identifier {
        case "Location":
            self.cellTextField.endEditing(true)
            self.delegate?.openLocation()
        case "Department":
            if let inpView = self.inputView as? UIPickerView{
                inpView.selectRow(1, inComponent: 1, animated: true)
            }
        default:
            print("")
        }
       if self.cellLabel.text == "SES Approver"{
        self.cellTextField.inputAccessoryView = toolBar
        let pickerView = UIPickerView()
        self.cellTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = 2
        self.sesApprover = ["", "Operations", "Capital Projects" , "Maintainence"]

        }
    }
}
extension DFTCreateTableViewCell : UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
        return self.departments.count
        }else if pickerView.tag == 2 {
            return self.sesApprover?.count ?? 0
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

        }else if pickerView.tag == 2 {
            return self.sesApprover?[row] ?? ""
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
        }else if pickerView.tag == 2 {
            self.dataModel?.sesApproverEmail = self.sesApprover?[row] ?? ""
            self.cellTextField.text = self.dataModel?.sesApproverEmail
        }
        else{
            self.dataModel?.reviewerEmail = self.reviewers[row].emailId
            self.dataModel?.reviewerID = self.reviewers[row].pId
            self.dataModel?.reviewerName = self.reviewers[row].name
            self.cellTextField.text = self.dataModel?.reviewerEmail
        }
    }
}
