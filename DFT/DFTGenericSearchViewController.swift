//
//  DFTGenericSearchViewController.swift
//  DFT
//
//  Created by Mohan on 27/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

protocol TableViewDisplayable {
    var label1 : String?{get set}
    
}
class DFTGenericSearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var cellModel : CellModel?
    var ticket : DFTHeaderType?
    var tableViewObjects : [TableViewDisplayable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        setupOfflineData()
        

    }
    func setupOfflineData() {
        switch cellModel?.identifier {
        case "PO":
            self.title = "PO"
            self.tableViewObjects.append(PO("00000012"))
            self.tableViewObjects.append(PO("00000342"))
            self.tableViewObjects.append(PO("00000312"))
            self.tableViewObjects.append(PO("00000412"))
            self.tableViewObjects.append(PO("00000512"))
            self.tableView.reloadData()
        case "WO":
            self.title = "WO"
            self.tableViewObjects.append(WO("00000012"))
            self.tableViewObjects.append(WO("00000342"))
            self.tableViewObjects.append(WO("00000312"))
            self.tableViewObjects.append(WO("00000412"))
            self.tableViewObjects.append(WO("00000512"))
            self.tableView.reloadData()
        case "WBS":
            self.title = "WBS"
            self.tableViewObjects.append(WBS("00000012"))
            self.tableViewObjects.append(WBS("00000342"))
            self.tableViewObjects.append(WBS("00000312"))
            self.tableViewObjects.append(WBS("00000412"))
            self.tableViewObjects.append(WBS("00000512"))
            self.tableView.reloadData()
        case "AccountingCategory":
            self.title = "Accounting Category"
            self.tableViewObjects.append(AccountingCategory("K"))
            self.tableViewObjects.append(AccountingCategory("A"))
            self.tableViewObjects.append(AccountingCategory("H"))
            self.tableViewObjects.append(AccountingCategory("P"))
            self.tableViewObjects.append(AccountingCategory("S"))
            self.tableView.reloadData()
        case "SESApprover":
            self.title = "SESApprover"
            self.tableViewObjects.append(SESApprover("anand.behera@incture.com"))
            self.tableViewObjects.append(SESApprover("surya.teja@incture.com"))
            self.tableViewObjects.append(SESApprover("pranav.nagpal@incture.com"))
            self.tableViewObjects.append(SESApprover("mohan.meruva@incture.com"))
            self.tableView.reloadData()
            
        default:
            print("")
        }
    }

}
extension DFTGenericSearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("noof rows\(String(describing: tableViewObjects.count))")
        return tableViewObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTGenericSearchTableViewCell") as! DFTGenericSearchTableViewCell
        cell.setData(currentObj: self.tableViewObjects[indexPath.row])
        return cell
    
    }
}
extension DFTGenericSearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch cellModel?.identifier {
        case "PO":
            self.ticket?.poNumber = self.tableViewObjects[indexPath.row].label1
            cellModel?.inputValue = self.ticket?.poNumber
        case "WO":
            self.ticket?.workOrderNo = self.tableViewObjects[indexPath.row].label1
            cellModel?.inputValue = self.ticket?.workOrderNo
        case "WBS":
            self.ticket?.wbsElement = self.tableViewObjects[indexPath.row].label1
            cellModel?.inputValue = self.ticket?.wbsElement
        case "AccountingCategory":
            self.ticket?.accountingCategory = self.tableViewObjects[indexPath.row].label1
            cellModel?.inputValue = self.ticket?.accountingCategory
        case "SESApprover":
            self.ticket?.sesApproverEmail = self.tableViewObjects[indexPath.row].label1
            cellModel?.inputValue = self.ticket?.sesApproverEmail
        default:
            print("Errroror")
        }

        self.navigationController?.popViewController(animated: true)
    }
}
