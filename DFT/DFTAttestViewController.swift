//
//  DFTAttestViewController.swift
//  DFT
//
//  Created by Mohan on 18/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class DFTAttestViewController: UIViewController {
    
    var cellLabels : [String] = ["Cost Object" , "PO" , "WO", "WBS" , "Accounting Category", "SES Approver" ]
    var ticket : DFTHeaderType?
    var modalLoadingIndicatorView = FUIModalLoadingIndicatorView()
    @IBOutlet var tableView: UITableView!
    
    @IBAction func OnVerifyPressed(_ sender: Any) {
        self.ticket?.status = "Verified"
        self.updateTicket()
    }
    
    @IBAction func OnRejectPressed(_ sender: Any) {
        self.ticket?.status = "Rejected"
        self.rejectTicket()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "Verification"
        // Do any additional setup after loading the view.
    }
    func getJsonBody() -> JSON{
    
        let header : JSON = [
            "dftNumber": String(self.ticket!.dftNumber!),
            "poNumber": self.ticket?.poNumber ?? "",
            "vendorAdminId": self.ticket?.vendorAdminID ?? "",
            "vendorId": self.ticket?.vendorID ?? "",
            "vendorName": self.ticket?.vendorName ?? "",
            "vendorAddress": self.ticket?.vendorAddress ?? "",
            "aribaSesNo": self.ticket?.aribaSesNo ?? "",
            "serviceProviderMail": self.ticket?.serviceProviderMail  ?? "",
            "serviceProviderId": self.ticket?.serviceProviderID ?? "",
            "serviceProviderName": self.ticket?.serviceProviderName ?? "",
            "ReviewerId": User.shared.id ?? "" , //TBD
            "ReviewerName": User.shared.fullName ?? "",
            "ReviewerEmail": User.shared.emailId ?? "",//TBD
            "sesApproverName": self.ticket?.sesApproverName ?? "",
            "sesApproverEmail": self.ticket?.sesApproverEmail ?? "",
            "department": self.ticket?.department ?? "",//TBD
            "location": self.ticket?.location ?? "",//TBD
            "accountingCategory": self.ticket?.accountingCategory ?? "",
            "costCenter": self.ticket?.costCenter ?? "",
            "sesNumber": self.ticket?.sesNumber ?? "",
            "workOrderNo": self.ticket?.workOrderNo ?? "",
            "signatureVersion": self.ticket?.signatureVersion ?? "",
            "wbsElement": self.ticket?.wbsElement ?? "",
            "deviceType": "iOS",//TBD
            "deviceId": "123",//TBD
            "status": self.ticket?.status ?? "",//TBD
            "createdBy": self.ticket?.createdBy ?? "" ,//TBD
            "updatedBy": User.shared.fullName ?? "",
            "vendorRefNumber": self.ticket?.vendorRefNumber ?? "",//TBD
            "createdOn":"2018-10-10T17:09:22.002Z" ,//TBD
            "reviewedBy": User.shared.id ?? "",
            "completedBy": self.ticket?.completedBy ?? "",
            "updatedOn":"2018-10-10T17:09:22.002Z",//TBD
            "reviewedOn":"2018-10-10T17:09:22.002Z",
            "completedOn":"2018-10-10T17:09:22.002Z",//TBD
            "well": self.ticket?.well ?? "",//TBD
            "field": self.ticket?.field ?? "",//TBD
            "facility": self.ticket?.facility ?? "",//TBD
            "wellPad": self.ticket?.wellPad ?? "",//TBD
            "ownerId": self.ticket?.ownerID ?? "",//TBD
            "startDate":"2018-10-10",//TBD
            "startTime":"10:10:10",//TBD
            "endDate":"2019-10-10",//TBD
            "endTime":"10:10:10"//TBD
        ]
        
        let body : [String : Any] =
            [
                "header": header,
                "comments": [[
                    "commentId": "",
                    "dftNumber": "",
                    "commentedByName": "surya",
                    "commentedOn": "2018-10-10T17:09:22.002Z",
                    "comment": "test"
                    ]],
                "attachments": [[
                    "attachmentId": "",
                    "dftNumber": "",
                    "attachmentName": "",
                    "dftAttachmentType": "",
                    "createdByName": "",
                    "createdOn": "2018-10-10T17:09:22.002Z",
                    "updatedByName": "",
                    "updatedOn": "2018-10-10T17:09:22.002Z",
                    "attachmentUrl": "www.google.com"
                    ]],
                "changeLog": [[
                    "activityId": "",
                    "dftNumber": "",
                    "wfInstanceId": "",
                    "status": "",
                    "createdOn": "2018-10-10T17:09:22.002Z",
                    "createdByName": ""
                    ]]
        ]
        
        return body
    }
    func verifyTicket() {
        var data : Data?
        let urlSession = (UIApplication.shared.delegate as! AppDelegate).sapURLSession
        let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.incture.basexsodata/updateFieldTicket.xsjs".asURL()
        var urlRequest = try! URLRequest(url: url, method: .post)
        do {
            data = try JSONSerialization.data(withJSONObject: self.getJsonBody(), options: .prettyPrinted)
            print(data)
        } catch let jsonError as NSError {
            print(jsonError.userInfo)
        }
        
        urlRequest.httpBody = data!
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                self.modalLoadingIndicatorView.dismiss()
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(json)
            } catch let jsonError as NSError {
                print(jsonError.userInfo)
            }
            
            guard let _ = data, error == nil else {
                print("Error in Updating DFT")
                print(error.debugDescription)
                return }
            do {
                print(response)
            } catch let error as NSError {
                print(error)
            }
        }
        dataTask.resume()

    }
    func rejectTicket(){
        
    }
    func updateTicket() {
        self.ticket?.poNumber = ""
        self.ticket?.workOrderNo = ""
        self.ticket?.accountingCategory = ""
        self.ticket?.wbsElement = ""
        self.ticket?.costCenter = ""
        self.ticket?.sesNumber = ""        
        self.verifyTicket()
    }
}
extension DFTAttestViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellLabel = self.cellLabels[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell") as! DFTCreateTableViewCell
        cell.cellLabel.text = currentCellLabel
        cell.cellTextField.placeholder = "--Select--"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
extension DFTAttestViewController : UITableViewDelegate{
    
}
