//
//  DFTTicketDetailViewController.swift
//  DFT
//
//  Created by Mohan on 18/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTTicketDetailViewController: UIViewController {
    var ticket : DFTHeaderType?
    var cellLabels : [String] = ["Vendor Reference No" , "Department", "Location", "Job Performed By" ,"Start Data", "End Date", "Create Date" ]
    let dateFormatter = DateFormatter()
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var vendorNameLabel: UILabel!
    @IBOutlet var vendorIdLabel: UILabel!
    @IBOutlet var vendorAddress: UILabel!
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            self.cellLabels = ["Comments", "Attachements"]
            self.nextButton.isHidden = false
            
        }else{
            self.cellLabels = ["Vendor Reference No" , "Department", "Location", "Job Performed By" ,"Start Data", "End Date", "Create Date" ]
             self.nextButton.isHidden = true

            }
        self.tableView.reloadData()
        
    }
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        self.vendorNameLabel.text = self.ticket?.vendorName
        self.vendorIdLabel.text = self.ticket?.vendorID
        self.vendorAddress.text = self.ticket?.vendorAddress
        self.nextButton.isHidden = true
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let dest = segue.destination as! DFTAttestViewController
        dest.ticket = self.ticket
    }

}
extension DFTTicketDetailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellLabel = cellLabels[indexPath.row]
        let dateTimeCell = self.tableView.dequeueReusableCell(withIdentifier: "DFTDateTimeTableViewCell") as! DFTDateTimeTableViewCell
        let textFieldCell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell") as! DFTCreateTableViewCell
        let commentsCell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCommentsTableViewCell") as! DFTCommentsTableViewCell
        dateTimeCell.textField2.isUserInteractionEnabled = false
        dateTimeCell.textField1.isUserInteractionEnabled = false
        textFieldCell.cellTextField.isUserInteractionEnabled = false
        if cellLabel == "Comments"{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCommentsTableViewCell") as! DFTCommentsTableViewCell
            if self.ticket?.comments.count != 0{
                cell.commentsTextView.text = self.ticket?.comments[0].comment
            }
            return cell
        }
        switch indexPath.row {
        case 0 :
            textFieldCell.cellLabel.text = cellLabel
            textFieldCell.cellTextField.text = self.ticket?.vendorRefNumber ?? ""
            return textFieldCell
        case 1 :
            textFieldCell.cellLabel.text = cellLabel
            textFieldCell.cellTextField.text = self.ticket?.department ?? ""
            return textFieldCell
        case 2 :
            textFieldCell.cellLabel.text = cellLabel
            textFieldCell.cellTextField.text = self.ticket?.location ?? ""
            return textFieldCell
        case 3 :
            textFieldCell.cellLabel.text = cellLabel
            textFieldCell.cellTextField.text = self.ticket?.createdBy ?? ""
            return textFieldCell

        case 4 :
            dateTimeCell.label1.text = "Start Date"
            dateTimeCell.textField1.text = self.ticket?.startDate?.toString()
            dateTimeCell.label2.text = "Start Time"
            dateTimeCell.textField2.text = self.ticket?.startTime?.toString()
            return dateTimeCell
        case 5 :
            dateTimeCell.label1.text = "End Date"
            dateTimeCell.label2.text = "End Time"
            dateTimeCell.textField1.text = self.ticket?.endDate?.toString()
            dateTimeCell.textField2.text = self.ticket?.endTime?.toString()

            return dateTimeCell

        case 6 :
            textFieldCell.cellLabel.text = cellLabel
            textFieldCell.cellTextField.text = self.ticket?.createdOn?.toString()
            return textFieldCell
        default:
            print("Out of Index")
            return textFieldCell
        }
    }

    
}
extension DFTTicketDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellLabel = self.cellLabels[indexPath.row]
        if cellLabel == "Comments"{
            return 120
        }
        switch indexPath.row {
        case 4 :
            return 85
        case 5 :
            return 85
        default:
            return 55
        }
    }
}

