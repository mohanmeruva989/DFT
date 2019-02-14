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
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel = CreateTicketViewModel(DFTType: .GeneralDFT)
        // Do any additional setup after loading the view.
    }

}
extension DFTCreateNewTicketViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tableViewModel?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData : CellModel = (self.viewModel?.tableViewModel?[indexPath.row])!
        switch cellData.dequeCell {
        case "DFTCreateTableViewCell":
          var  cell = tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell")! as! DFTCreateTableViewCell
          cell.setData(cellData)
          return cell
        case "DFTDateTimeTableViewCell" :
           var cell = tableView.dequeueReusableCell(withIdentifier: "DFTDateTimeTableViewCell")! as! DFTDateTimeTableViewCell
           cell.setData(cellData)
           return cell
        default:
            print("Invalid deque cell")
            return UITableViewCell()
        }

    }
}
extension DFTCreateNewTicketViewController : UITableViewDelegate{}
