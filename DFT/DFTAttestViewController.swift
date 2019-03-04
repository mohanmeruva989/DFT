//
//  DFTAttestViewController.swift
//  DFT
//
//  Created by Mohan on 18/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData
import AlamofireImage
import Alamofire

class DFTAttestViewController: UIViewController {
    
    var cellLabels : [String] = ["PO" , "WO", "WBS" , "Accounting Category", "SES Approver"  ]
    var ticket : DFTHeaderType?
    var modalLoadingIndicatorView = FUIModalLoadingIndicatorView()
    var role : String?
    var action : String?
    var sesApprover : [String] = ["", "abc@def.com", "def@ghi.com" , "jkl@mno.com"]
    var attestViewModel : AttestTicketViewModel?
    var selectedIndexPath : IndexPath?
    @IBOutlet var signatureView: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    let toolBar = UIToolbar().toolbarPicker(mySelect: #selector(dismissPicker))

    @IBAction func OnVerifyPressed(_ sender: Any) {
        if validateFields(){
            self.ticket?.status = "Ticket Verified"
            self.role = "1"
            self.action = "Review"
            self.updateTicket()
        }else {
            let alertController = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true) })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    @IBAction func OnRejectPressed(_ sender: Any) {
            self.ticket?.status = "Ticket Rejected"
            self.role = "1"
            self.action = "Reject"
            self.updateTicket()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "Verification"
        self.attestViewModel = AttestTicketViewModel()
        if User.shared.signatureUrl != nil {
            do{
                try! self.signatureView.af_setImage(withURL:  (User.shared.signatureUrl!.asURL()))
            }
            catch {
                
            }
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    func validateFields() -> Bool {
        if self.ticket!.poNumber! == "" ||
        self.ticket!.workOrderNo! == "" ||
        self.ticket!.accountingCategory! == "" ||
            self.ticket!.sesApproverEmail! == ""{
            return false
        }
        return true
    }
    func getJsonBody() -> JSON{
    
        let header : JSON = [
            "role" : self.role ?? "",
            "action" : self.action ?? "",
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
            "ReviewerEmail": User.shared.emailId ?? "",
            "sesApproverName": self.ticket?.sesApproverName ?? "",
            "sesApproverEmail": self.ticket?.sesApproverEmail ?? "",
            "department": self.ticket?.department ?? "",
            "location": self.ticket?.location ?? "",
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
            "createdOn": self.ticket?.createdOn?.toString() ?? "" ,//TBD
            "reviewedBy": User.shared.id ?? "",
            "completedBy": self.ticket?.completedBy ?? "",
            "updatedOn": LocalDateTime.from(utc: Date()).toString(),//TBD
            "reviewedOn":LocalDateTime.from(utc: Date()).toString(),
            "completedOn":"",//TBD
            "well": self.ticket?.well ?? "",//TBD
            "field": self.ticket?.field ?? "",//TBD
            "facility": self.ticket?.facility ?? "",//TBD
            "wellPad": self.ticket?.wellPad ?? "",//TBD
            "ownerId": "P000064",//TBD
            "startDate":self.ticket?.startDate?.toString()[0..<10] ?? "",//TBD
            "startTime":self.ticket?.startTime?.toString() ?? "",//TBD
            "endDate": self.ticket?.endDate?.toString()[0..<10] ?? "",//TBD
            "endTime": self.ticket?.endTime?.toString() ?? "",//TBD
            "workflowId": self.ticket?.wfInstanceID ?? ""
        ]
        var attachments : [JSON] = []
        for each in (self.ticket?.attachments)!{
        
            let attach : JSON =  [
                "attachmentId": each.attachmentID ?? "",
                "dftNumber": self.ticket?.dftNumber ?? "",
                "attachmentName": each.attachmentName ?? "",
                "dftAttachmentType": each.dftAttachmentType ?? "",
                "createdByName": each.createdByName ?? "",
                "createdOn": each.createdOn ?? "",
                "updatedByName": User.shared.fullName ?? "",
                "updatedOn": LocalDateTime.from(utc: Date()).toString() ?? "",
                "attachmentUrl": each.attachmentUrl
            ]
            attachments.append(attach)
        }
//        if attachments.count == 0{
//            let attach : JSON =  [
//                "attachmentId": "",
//                "dftNumber": "",
//                "attachmentName": "",
//                "dftAttachmentType": "",
//                "createdByName": "",
//                "createdOn": "",
//                "updatedByName": "",
//                "updatedOn": "",
//                "attachmentUrl": ""
//            ]
//            attachments.append(attach)
//        }

        let changeLog : [JSON] =  [[
            "activityId": "",
            "dftNumber": self.ticket?.dftNumber?.description ?? "",
            "wfInstanceId": "",
            "status": self.ticket?.status ?? "",
            "createdOn": Date().description ,
            "createdByName": User.shared.fullName ?? ""
            ]]
  
        var comments : [JSON] = []
        for each in (self.ticket?.comments)!{
            
            let attach : JSON =  [
                "commentId": each.commentID?.description ?? "",
                "dftNumber": each.dftNumber?.description ?? "",
                "commentedByName": each.commentedByName ?? "",
                "commentedOn": each.commentedOn ?? "",
                "comment": each.comment ?? ""]
            comments.append(attach)
        }

        
        
        let body : [String : Any] = [
                "header": header,
                "comments": comments,
                "attachments": attachments,
                "changeLog": changeLog
        ]
        
        return body
    }
    func verifyTicket() {
        DispatchQueue.main.async {
            self.modalLoadingIndicatorView.show(inView: self.view)
        }
        var data : Data?
        let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.incture.basexsodata/updateFieldTicket.xsjs".asURL()
        var urlRequest = try! URLRequest(url: url, method: .post)
        do {
            data = try JSONSerialization.data(withJSONObject: self.getJsonBody(), options: .prettyPrinted)
            print(data)
            let sd = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            print("****param****")
            print(sd.printJson())
            print("****param end****") 
        } catch let jsonError as NSError {
            print(jsonError.userInfo)
        }
        
        urlRequest.httpBody = data!
        let dataTask = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                self.modalLoadingIndicatorView.dismiss()
                var message = ""
                if self.action == "Review"{
                    message = "DFT \(self.ticket!.dftNumber!.description) has been Verified successfully"
                    self.signAttachment()
                }
                else{
                    message = "DFT \(self.ticket!.dftNumber!.description) has been Rejected successfully"
                }
                let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
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

    func updateTicket() {

        self.verifyTicket()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showGenericSearchController"{
           if let indexPath = self.selectedIndexPath{
            if let dest = segue.destination as? DFTGenericSearchViewController{
                 dest.cellModel = self.attestViewModel?.tableViewModel![indexPath.row]
                 dest.ticket  = self.ticket
                }
            }
        }
    }
    
    func signAttachment(){
        let urlRequest = try! URLRequest(url: "https://mobile-hkea136m18.hana.ondemand.com/com.incture.documentService/updateAttachmentContent?approverId=\((self.ticket?.vendorID!.description)!))&fieldTicketNo=\((self.ticket?.dftNumber!.description)!)", method: .get)
        DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in

            print("Merge Successful")
            
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
        }.resume()
        
        
//        Alamofire.request("\(BaseUrl.apiURL)/com.incture.documentService/updateAttachmentContent?approverId=\((self.ticket?.murphyEngineerId!)!))&fieldTicketNo=\((self.ticket?.FieldTicketNum!)!)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
//            .responseString{ response in
//                if response.result.isSuccess{
//                    print("File merging is success")
//                }else{
//                    print("File merging Failed")
//                    
//                }
//                print(response)
//                
//        }
    }
}
extension DFTAttestViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attestViewModel?.tableViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel : CellModel = attestViewModel!.tableViewModel![indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell") as!
        DFTCreateTableViewCell
        cell.setData(cellModel)
        
        
        
        
//        let currentCellLabel = self.cellLabels[indexPath.row]
//        cell.cellLabel.text = currentCellLabel
//        cell.cellTextField.placeholder = "--Type here--"
//        cell.cellTextField.tag = indexPath.row
//        if currentCellLabel == "SES Approver"{
//            let pickerView = UIPickerView()
//            cell.cellTextField.placeholder = "--Select--"
//            cell.cellTextField.textContentType = UITextContentType.emailAddress
//            cell.cellTextField.text = self.ticket?.sesApproverEmail
//            cell.cellTextField.inputAccessoryView = toolBar
//            cell.cellTextField.inputView = pickerView
//            pickerView.dataSource = self
//            pickerView.delegate = self
//            pickerView.tag = 1
//
//        }
//            cell.cellTextField.delegate = self
                return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    @objc func dismissPicker(){
        self.view.endEditing(true)
        self.tableView.reloadData()
    }
    
    
}
extension DFTAttestViewController : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.sesApprover.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.sesApprover[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.ticket?.sesApproverEmail = self.sesApprover[row]
    }
}
extension DFTAttestViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.attestViewModel!.tableViewModel![indexPath.row].identifier {
        case "PO","WO","WBS","AccountingCategory", "SESApprover":
            self.selectedIndexPath = indexPath
            self.performSegue(withIdentifier: "showGenericSearchController", sender: self)
        default:
            print("asdfasf")
        }
    }
    
}
extension DFTAttestViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {

        case 0 :
            self.ticket?.poNumber = textField.text
        case 1:
            self.ticket?.workOrderNo = textField.text
        case 2:
            self.ticket?.wbsElement = textField.text
        case 3:
            self.ticket?.accountingCategory = textField.text
        default:
            print("")
        }
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
