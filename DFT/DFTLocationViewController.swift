//
//  DFTLocationViewController.swift
//  DFT
//
//  Created by Mohan on 19/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTLocationViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var wells = [Well]()
    var wellpads = [Wellpad]()
    var fields = [Field]()
    var facilities = [Facility]()
    var currentLocationType : String?{
        didSet{
            switch currentLocationType{
            case "Fields":
                self.tableValues = fields
            case "Facilities":
                self.tableValues = facilities
            case "Wellpads":
                self.tableValues = wellpads
            case "Wells":
                self.tableValues = wells
            default :
                print("")
            }
        }
    }
    var tableValues : [Location]?
    var dataModel : DFTHeaderType?
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        wells.append(Well(name: "Briggs 10H"))
        wells.append(Well(name: "Briggs 11H"))
        wells.append(Well(name: "Briggs 20H"))
        
        wellpads.append(Wellpad(name: "Briggs 10H-11H", wells: nil))
        wellpads.append(Wellpad(name: "Briggs 13H-14H", wells: nil))
        wellpads.append(Wellpad(name: "Briggs 20H-25H", wells: nil))
        
        facilities.append(Facility(name: "Tom", wellpads: nil))
        facilities.append(Facility(name: "Fernandez", wellpads: nil))
        facilities.append(Facility(name: "Lenhart", wellpads: nil))
        
        fields.append(Field(name: "Karnes", facilites: nil))
        fields.append(Field(name: "North Tilden", facilites: nil))
        fields.append(Field(name: "South Tilden", facilites: nil))
        self.currentLocationType = "Fields" 
        self.tableView.reloadData()
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = true
    }
    
    

}
extension DFTLocationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableValues!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTLocationTableViewCell")
        as! DFTLocationTableViewCell
        cell.cellLabel.text = tableValues![indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DFTLocationViewController") as! DFTLocationViewController
        vc.dataModel = self.dataModel
        switch currentLocationType {
            
        case "Fields":
            vc.currentLocationType = "Facilities"
            
        case "Facilities":
            vc.currentLocationType = "Wellpads"
        case "Wellpads":
            vc.currentLocationType = "Wells"
        case "Wells":
            self.navigationController?.popViewController(animated: true)
        default:
            print("")
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.title = self.currentLocationType

    }
}
