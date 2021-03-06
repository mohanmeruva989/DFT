//
//  TicketCell.swift
//  DFT
//
//  Created by Soumya Singh on 01/02/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import SAPOData

class TicketCell: UITableViewCell {

    @IBOutlet var upperView: UIView!
    @IBOutlet var markerView: UIView!
    @IBOutlet var ticketTitleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var departmentLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var departmentKeyValue: UILabel!
    @IBOutlet var locationKeyValue: UILabel!
    @IBOutlet var vendorRefNoKeyValue: UILabel!
    @IBOutlet var vendorRefLabel: UILabel!
    @IBOutlet var vendorNameKey: UILabel!
    @IBOutlet var vendorNameLabel: UILabel!
    @IBOutlet var extraLabelKey: UILabel!
    @IBOutlet var extraLabelValue: UILabel!
    @IBOutlet weak var heightConstraint1: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint2: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        upperView.layer.borderColor = UIColor.lightGray.cgColor
        upperView.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(ticketHeader : DFTHeaderType)
    {
        
        ticketTitleLabel.text = String(ticketHeader.dftNumber!)

        if ticketHeader.department == "" {
            departmentLabel.text = " - "
        }else{
            departmentLabel.text = ticketHeader.department
        }

        locationKeyValue.sizeToFit()
        locationLabel.text = ticketHeader.location ?? ""
        
        if ticketHeader.location != ""{
            locationLabel.text = ticketHeader.location
        }
        else{
            locationLabel.text = "   -   "
        }
        if ticketHeader.status == "Ticket Created"{
            markerView.backgroundColor = UIColor.orange
//            UIColor(red : 246/255, green : 142/255, blue : 86/255, alpha : 1)
        }
        else if ticketHeader.status == "Ticket Rejected"{
            markerView.backgroundColor = UIColor.red
        }
        else if ticketHeader.status == "Ticket Reviewed"{
            markerView.backgroundColor = UIColor(red : 77/255, green : 184/255, blue : 255/255, alpha : 1)
        }
        else if ticketHeader.status == "Ticket Verified"{
            markerView.backgroundColor = UIColor(red : 77/255, green : 184/255, blue : 255/255, alpha : 1)
        }
        else {
            markerView.backgroundColor = UIColor.darkGray
        }
        let ticketTime = self.decodeTime(timeString: ticketHeader.createdOn!)
        timeLabel.text = ticketTime
        
        vendorRefNoKeyValue.text = "Vendor Ref No :"
        if ticketHeader.vendorRefNumber == "" {
            vendorRefLabel.text = " - "
        }else{
            vendorRefLabel.text = ticketHeader.vendorRefNumber
        }
        if User.shared.role == UserRole.ServiceProvider{
            extraLabelKey.text = ""
            extraLabelValue.text = ""
            vendorNameKey.text = ""
            vendorNameLabel.text = ""
            heightConstraint1.constant = 0
            heightConstraint2.constant = 0

        }else{
            extraLabelKey.text = "Vendor ID:"
            extraLabelValue.text = ticketHeader.vendorName
            vendorNameKey.text = "VendorName:"
            vendorNameLabel.text = ticketHeader.vendorAddress
        }
        
    }
    
//    func setDataForTasks(task : Task)
//    {
//        ticketTitleLabel.text = task.FieldTicketNum
//        departmentLabel.text = task.Department
//        if task.CreatedByName == nil {
//            locationLabel.text = task.CreatedByID
//        }
//        else{
//            locationLabel.text = task.CreatedByName
//        }
//        locationKeyValue.text = "Created By :"
//        vendorRefNoKeyValue.text = "Vendor Ref No:"
//        vendorRefLabel.text = task.vendorRefNum
//        vendorNameKey.text = "Vendor ID:"
//        vendorNameLabel.text = task.vendorID
//        extraLabelKey.text = "Vendor Name:"
//        extraLabelValue.text = task.vendorName
//        timeLabel.text = task.CreatedTime
//        markerView.backgroundColor = UIColor(red : 246/255, green : 142/255, blue : 86/255, alpha : 1)
//
//    }
    
    public func decodeTime(timeString : LocalDateTime) -> String{

        let dateString = timeString.toString()[11..<19]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        let localTime: Date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent //Set timezone that you want
        let somedateString = dateFormatter.string(from: localTime)
        return somedateString
    }
}
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    func decodeTime(timeString : String) -> String{
        let hour = timeString[2 ..< 4] // returns String "o, worl"
        let minutes = timeString[5 ..< 7]
        let seconds = timeString[8 ..< 10]
        let timeData = hour + ":" + minutes + ":" + seconds
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let myDate = dateFormatter.date(from: timeData)!
        dateFormatter.dateFormat = "hh:mm a"
        let somedateString = dateFormatter.string(from: myDate)
        return somedateString
    }

}

