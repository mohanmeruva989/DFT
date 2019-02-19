//
//  DFTAllTicketsViewController.swift
//  DFT
//
//  Created by Mohan on 10/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import SAPFiori


class DFTAllTicketsViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var allTickets : [DFTHeaderType] = [DFTHeaderType]()
    var filteredTickets : [DFTHeaderType]? = nil
    var refreshControl = UIRefreshControl()
    var selectedTicketNumber : String?
    var selectedTicket : DFTHeaderType?
    let modalLoadingIndicatorView = FUIModalLoadingIndicatorView()
    public var loadEntitiesBlock: ((_ completionHandler: @escaping ([DFTHeaderType]?, Error?) -> Void) -> Void)?
    lazy  var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        // Setup the Search Controller
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search for DFT's "
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        return searchController
    }()
    @IBOutlet var addNewTicketButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.navigationItem.rightBarButtonItem = nil
        //Animate the searchBar
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.searchController = self.searchController
        }
        self.navigationItem.searchController?.searchBar.becomeFirstResponder()
        self.searchController.isActive = true

        self.view.layoutIfNeeded()

    }
    
    @IBAction func addNewTicketButtonTapped(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestEntities(completionHandler: {_ in self.tableView.reloadData()})
        let nib = UINib(nibName: "TicketCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TicketCell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight  = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        self.title = "My DFT's"
        self.refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(self.refreshControl)
        // Do any additional setup after loading the view.
    }
    
    func requestEntities(completionHandler: @escaping (Error?) -> Void) {
        self.modalLoadingIndicatorView.show(inView: self.view, animated: true)
        self.loadEntitiesBlock!() { entities, error in
            self.modalLoadingIndicatorView.dismiss()
            if let error = error {
                completionHandler(error)
                return
            }
            self.allTickets = entities!
            self.allTickets = self.allTickets.sorted{ $0.dftNumber! > $1.dftNumber! }
            completionHandler(nil)
        }
    }
    @objc func refresh() {
        let oq = OperationQueue()
        oq.addOperation({
            self.requestEntities(completionHandler: {_ in
                OperationQueue.main.addOperation({
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()})
                })
        })
    }


}

extension DFTAllTicketsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.searchBar.text != ""{
            return self.filteredTickets!.count
        }
        else{
            return self.allTickets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell")! as! TicketCell
                cell.clipsToBounds = true
                cell.selectionStyle = .none
                cell.setData(ticketHeader : self.allTickets[indexPath.row])


                 if self.searchController.searchBar.text != ""{
                    cell.setData(ticketHeader : self.filteredTickets![indexPath.row])
                }
                 else{
                    cell.setData(ticketHeader : self.allTickets[indexPath.row])
                }
                return cell
    }
    
}
extension DFTAllTicketsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if User.shared.role == UserRole.Reviewer {
            self.selectedTicketNumber = String(self.allTickets[indexPath.row].dftNumber!)
            self.selectedTicket = self.allTickets[indexPath.row]
            self.performSegue(withIdentifier: "TicketDetail", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TicketDetail"{
           var dest = segue.destination as! DFTTicketDetailViewController
            dest.title = self.selectedTicketNumber
            dest.ticket = self.selectedTicket
        }
    }
}
extension DFTAllTicketsViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText : String = searchController.searchBar.text ?? ""
        if searchText != "" {
            self.filteredTickets = allTickets.filter{String($0.dftNumber!).contains(searchText)
            }
        }
        self.tableView.reloadData()
    }
}
extension DFTAllTicketsViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.searchController = nil
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateSearchResults(for: self.searchController)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationItem.searchController = nil
        return true
    }
    
}
extension DFTAllTicketsViewController : UISearchControllerDelegate{
    
}
