//
//  DFTTicketDetailViewController.swift
//  DFT
//
//  Created by Mohan on 18/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class DFTTicketDetailViewController: UIViewController {
    var ticket : DFTHeaderType?
    var cellLabels : [String] = ["Vendor Reference No" , "Department", "Location", "Job Performed By" ,"Start Data", "End Date", "Create Date" ]
    let dateFormatter = DateFormatter()
    var ticketAttachments : [JSON]?
    var ticketComments : [JSON]?{
        didSet{
            DispatchQueue.main.async {
                if self.ticketComments != nil {
                    if !self.ticketComments!.isEmpty{
                self.commentsView.text = (self.ticketComments!.last!)["comment"] as? String
                    }
                }
            }
        }
    }

    @IBOutlet var attachmentView: UIView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var vendorNameLabel: UILabel!
    @IBOutlet var vendorIdLabel: UILabel!
    @IBOutlet var vendorAddress: UILabel!
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            self.nextButton.isHidden = false
            self.attachmentView.isHidden = false
            
        }else{
            self.cellLabels = ["Vendor Reference No" , "Department", "Location", "Job Performed By" ,"Start Data", "End Date", "Create Date" ]
             self.nextButton.isHidden = true
            self.attachmentView.isHidden = true


            }
        self.tableView.reloadData()
        
    }

    @IBOutlet var tableView2: UITableView!
    @IBOutlet var commentsView: UITextView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView2.dataSource = self
        self.tableView2.delegate = self
        self.tableView2.tag = 2
        self.tableView2.tableFooterView = UIView()


        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        self.vendorNameLabel.text = self.ticket?.vendorName
        self.vendorIdLabel.text = self.ticket?.vendorID
        self.vendorAddress.text = self.ticket?.vendorAddress
        self.nextButton.isHidden = true
        self.attachmentView.isHidden = true
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        if self.ticket?.comments.count != 0 {
        self.commentsView.text = self.ticket?.comments[0].comment
        }
        
        self.commentsView.isUserInteractionEnabled = false
        self.getAttachments()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let dest = segue.destination as! DFTAttestViewController
        dest.ticket = self.ticket
    }

}
extension DFTTicketDetailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2{
            return self.ticketAttachments?.count ?? 0
        }
        
        return cellLabels.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == 2 {
            return "Attachments"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 2{
            let cell = self.tableView2.dequeueReusableCell(withIdentifier: "DFTGalleryTableViewCell") as! DFTGalleryTableViewCell
            let id = URL(string: self.ticketAttachments?[indexPath.row]["attachmentUrl"] as! String)?.lastPathComponent
            let absUrl = URL(string: "https://docservicesx5qv5zg6ns.hana.ondemand.com/AppDownload/inctureDft/documents/download/" + id!)
            cell.label.text  =  self.ticketAttachments?[indexPath.row]["attachmentName"] as? String
//            cell.uploadedOnLabel.text = self.ticketAttachments?[indexPath.row]["createdOn"] as? Date
            cell.galleryImage.af_setImage(withURL: absUrl!, placeholderImage: UIImage(named: "Imageplaceholder"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .curlDown(0.8), runImageTransitionIfCached: false, completion: nil)
            
                return cell
        }
        
        
        let cellLabel = cellLabels[indexPath.row]
        let dateTimeCell = self.tableView.dequeueReusableCell(withIdentifier: "DFTDateTimeTableViewCell") as! DFTDateTimeTableViewCell
        let textFieldCell = self.tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell") as! DFTCreateTableViewCell
        dateTimeCell.textField2.isUserInteractionEnabled = false
        dateTimeCell.textField1.isUserInteractionEnabled = false
        textFieldCell.cellTextField.isUserInteractionEnabled = false
        if cellLabel == "Comments" || cellLabel == "Attachments"{
            
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
            guard let startDate : String = self.ticket?.startDate?.toString() else{
                textFieldCell.cellTextField.text = " - "
                return textFieldCell
            }
            dateTimeCell.textField1.text = convertTimeStamp(dateTimeString: startDate)
            dateTimeCell.label2.text = "Start Time"
            dateTimeCell.textField2.text = self.ticket?.startTime?.toString()
            return dateTimeCell
        case 5 :
            dateTimeCell.label1.text = "End Date"
            dateTimeCell.label2.text = "End Time"
            guard let endDate : String = self.ticket?.endDate?.toString() else{
                textFieldCell.cellTextField.text = " - "
                return textFieldCell
            }
            dateTimeCell.textField1.text = convertTimeStamp(dateTimeString: endDate)
            dateTimeCell.textField2.text = self.ticket?.endTime?.toString()

            return dateTimeCell

        case 6 :
            textFieldCell.cellLabel.text = cellLabel
            guard let createdOn : String = self.ticket?.createdOn?.toString() else{
                textFieldCell.cellTextField.text = " - "
                return textFieldCell
            }
            textFieldCell.cellTextField.text = convertTimeStamp(dateTimeString: createdOn)
            return textFieldCell
        default:
            print("Out of Index")
            return textFieldCell
        }
    }
    
    
}
extension DFTTicketDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 2{
            return 90
        }
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

extension DFTTicketDetailViewController {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.ticketAttachments?.count ?? 0
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DFTGalleryCollectionViewCell", for: indexPath) as! DFTGalleryCollectionViewCell
//        do {
//            let id = URL(string: self.ticketAttachments![indexPath.row]["attachmentUrl"] as! String)?.lastPathComponent
//            let absUrl = URL(string: "https://docservicesx5qv5zg6ns.hana.ondemand.com/AppDownload/inctureDft/documents/download/" + id!)
//            try  cell.galleryImage.af_setImage(withURL: absUrl!)
//        }
//        catch{
//
//        }
//        return cell
//    }
    func getAttachments() {
        
        do{
            let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.dft.xsodata/getFieldTicketDetails.xsodata/DFTHeader(\(self.ticket!.dftNumber!))?$expand=Comments,ChangeLogs,Attachments&$format=json".asURL()
            let urlRequest = try! URLRequest(url: url, method: .get)
            
            let dataTask = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSON
                    guard let d = json["d"] as? JSON else{
                        return
                    }
                    guard let attachments = d["Attachments"] as? JSON else{
                        return
                    }
                    guard let results = attachments["results"] as? [JSON] else{
                        return
                    }
                    guard let comm = d["Comments"] as? JSON else{
                        return
                    }
                    guard let comm2 = comm["results"] as? [JSON] else{
                        return
                    }
                    DispatchQueue.main.async {
                        self.ticketAttachments = results
                        self.ticketComments = comm2
                        self.tableView2.reloadData()
                    }
                    
                    print(json)
                } catch let jsonError as NSError {
                    print(jsonError.userInfo)
                }
                
                guard let _ = data, error == nil else {
                    print("Error in PostinG create payload")
                    return }
                do {
                    print(response)
                } catch let error as NSError {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
    

}
public func convertTimeStamp(dateTimeString : String) -> String
{
    let dateString = dateTimeString[0..<10]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let dateStamp = dateFormatter.date(from: dateString) else {
        return " - "
    }
    print("createdDate \(dateStamp)")
    dateFormatter.timeZone = TimeZone(abbreviation: "IST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMM yyyy" //Specify your format that you want
    let strDate = dateFormatter.string(from: dateStamp)
    return strDate
}
