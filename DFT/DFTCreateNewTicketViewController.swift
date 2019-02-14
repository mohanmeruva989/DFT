//
//  DFTCreateNewTicketViewController.swift
//  DFT
//
//  Created by Mohan on 13/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData

class DFTCreateNewTicketViewController: UIViewController {
    var viewModel : CreateTicketViewModel?
    @IBOutlet var attachmentView: UIView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.viewModel = CreateTicketViewModel(DFTType: .Attachment)
            self.tableView.reloadData()
            self.attachmentView.isHidden = false
        }else{
            self.viewModel = CreateTicketViewModel(DFTType: .GeneralDFT)
            self.tableView.reloadData()
            self.attachmentView.isHidden = true
        }
    }
    
    @IBAction func onSubmitPress(_ sender: Any) {
        self.createDFTPayload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel = CreateTicketViewModel(DFTType: .GeneralDFT)
        self.tableView.tableFooterView = UIView()
        self.attachmentView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func createDFTPayload() {
        var header : JSON = [
        "dftNumber": "",
        "poNumber": "",
        "vendorAdminId": "",
        "vendorId": "",
        "vendorName": "",
        "vendorAddress": "",
        "aribaSesNo": "",
        "serviceProviderMail": "",//TBD
        "serviceProviderId": "P000065",//TBD
        "serviceProviderName": "Anand Behera",//TBD
        "ReviewerId": "P000066",//TBD
        "ReviewerName": "Nuzha Rukiya",//TBD
        "ReviewerEmail": "",//TBD
        "sesApproverName": "",
        "sesApproverEmail": "",
        "department": "Well Work",//TBD
        "location": "",//TBD
        "accountingCategory": "",
        "costCenter": "",
        "sesNumber": "",
        "workOrderNo": "",
        "signatureVersion": "",
        "wbsElement": "",
        "deviceType": "", //TBD
        "deviceId": "", //TBD
        "status": "", //TBD
        "createdBy": "", //TBD
        "updatedBy": "",
        "vendorRefNumber": "", //TBD
        "createdOn":"2018-10-10T17:09:22.002Z", //TBD
        "reviewedBy": "",
        "completedBy": "",
        "updatedOn":"2018-10-10T17:09:22.002Z", //TBD
        "reviewedOn":"",
        "completedOn":"",
        "well": "",//TBD
        "field": "",//TBD
        "facility": "",//TBD
        "wellPad": "",//TBD
        "ownerId": "", //TBD
        "startDate":"", //TBD
        "startTime":"",//TBD
        "endDate":"",//TBD
        "endTime":""//TBD
        ]
    }

}
extension DFTCreateNewTicketViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tableViewModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellData : CellModel = (self.viewModel?.tableViewModel?[indexPath.row])!
        switch cellData.identifier {
        case "StartDetails":
            return 100
        case "EndDetails":
            return 100
        default:
            return 70
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData : CellModel = (self.viewModel?.tableViewModel?[indexPath.row])!
        switch cellData.dequeCell {
        case "DFTCreateTableViewCell":
            let  cell = tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell")! as! DFTCreateTableViewCell
          cell.setData(cellData)
          return cell
        case "DFTDateTimeTableViewCell" :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DFTDateTimeTableViewCell")! as! DFTDateTimeTableViewCell
           cell.setData(cellData)
           return cell
        case "DFTCommentsTableViewCell" :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DFTCommentsTableViewCell")! as! DFTCommentsTableViewCell
            cell.setData(cellData)
            return cell
        case "DFTGalleryTableViewCell" :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DFTGalleryTableViewCell")! as! DFTGalleryTableViewCell
            cell.setData(cellData)
            return cell
        default:
            print("Invalid deque cell")
            return UITableViewCell()
        }

    }
}
extension DFTCreateNewTicketViewController : UITableViewDelegate{}
