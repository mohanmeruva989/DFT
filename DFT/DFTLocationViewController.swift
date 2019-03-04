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
    var SelectedIndex :IndexPath? = nil{
        didSet{
            if SelectedIndex != nil{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(locationSelected))
            }else{
            self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    var selectedField : String = ""
    var selectedFacility : String = ""
    var selectedWellpad : String = ""
    var selectedWell : String = ""
    
    var currentLocationType : String?{
        didSet{
            switch currentLocationType!{
            case "Fields":
                fields.removeAll()
                fields.append(Field(name: "Karnes", facilites: nil))
                fields.append(Field(name: "North Tilden", facilites: nil))
                fields.append(Field(name: "South Tilden", facilites: nil))
                self.tableValues = fields
            case "Facilities":
                facilities.removeAll()
                facilities.append(Facility(name: "Tom", wellpads: nil))
                facilities.append(Facility(name: "Fernandez", wellpads: nil))
                facilities.append(Facility(name: "Lenhart", wellpads: nil))
                self.tableValues = facilities
            case "Wellpads":
                wellpads.removeAll()
                wellpads.append(Wellpad(name: "Briggs 10H-11H", wells: nil))
                wellpads.append(Wellpad(name: "Briggs 13H-14H", wells: nil))
                wellpads.append(Wellpad(name: "Briggs 20H-25H", wells: nil))
                self.tableValues = wellpads
            case "Wells":
                wells.removeAll()
                wells.append(Well(name: "Briggs 10H"))
                wells.append(Well(name: "Briggs 11H"))
                wells.append(Well(name: "Briggs 20H"))
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

        if self.currentLocationType == nil{
            self.currentLocationType = "Fields"
        }
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = true
        self.tableView.isEditing = true
        self.title = self.currentLocationType
        

    }
    
    @objc func locationSelected(){
        
        
        switch currentLocationType!{
            case "Fields":
            self.selectedField = self.tableValues![SelectedIndex!.row].name
            case "Facilities":
            self.selectedFacility = self.tableValues![SelectedIndex!.row].name
            case "Wellpads":
            self.selectedWellpad = self.tableValues![SelectedIndex!.row].name
            case "Wells":
            self.selectedWell = self.tableValues![SelectedIndex!.row].name

            default:
            print("")

            }        
        self.dataModel?.field = self.selectedField
        self.dataModel?.facility = self.selectedFacility
        self.dataModel?.wellPad = self.selectedWellpad
        self.dataModel?.well = self.selectedWell
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: DFTCreateNewTicketViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}

extension DFTLocationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableValues!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DFTLocationTableViewCell")
        as! DFTLocationTableViewCell
        cell.cellButton.setTitle(tableValues![indexPath.row].name, for: .normal)
        cell.cellButton.titleLabel?.text = tableValues![indexPath.row].name
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let temp = self.SelectedIndex{
            if temp == indexPath{
                self.SelectedIndex = nil
            }
            self.tableView.deselectRow(at:temp , animated: true)
            
        }
        self.SelectedIndex = indexPath
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension DFTLocationViewController : LocationCellDelgate{
    func didLocationTapped(cell : DFTLocationTableViewCell) {
        let index = self.tableView.indexPath(for: cell)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DFTLocationViewController") as! DFTLocationViewController
        vc.dataModel = self.dataModel
        switch currentLocationType! {
        case "Fields":
            vc.currentLocationType = "Facilities"
            self.selectedField = self.tableValues![index!.row].name
        case "Facilities":
            vc.currentLocationType = "Wellpads"
            self.selectedFacility = self.tableValues![index!.row].name

        case "Wellpads":
            vc.currentLocationType = "Wells"
            self.selectedWellpad = self.tableValues![index!.row].name

        case "Wells":
            self.selectedWell = self.tableValues![index!.row].name
            self.dataModel?.field = self.selectedField
            self.dataModel?.facility = self.selectedFacility
            self.dataModel?.wellPad = self.selectedWellpad
            self.dataModel?.well = self.selectedWell
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: DFTCreateNewTicketViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        default:
            print("")
        }
        vc.dataModel = self.dataModel
        vc.selectedFacility = self.selectedFacility
        vc.selectedField = self.selectedField
        vc.selectedWellpad = self.selectedWellpad
        vc.selectedWell = self.selectedWell
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
