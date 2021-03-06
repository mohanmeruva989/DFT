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
    var firstTimeLoading : Bool = true
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
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for DFT's "
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        return searchController
    }()
    @IBOutlet var addNewTicketButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.navigationItem.rightBarButtonItems = []
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = self.firstTimeLoading ? self.refresh() : nil
    }
    func animateTableView() {
        self.tableView.isHidden = true
        let tableViewHeight = self.tableView.bounds.size.height
        for i in self.tableView.visibleCells{
            i.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        self.tableView.isHidden = false
        var index = 0
        for j in self.tableView.visibleCells{
            UIView.animate(withDuration: 1, delay: 0.08*Double(index), options: .transitionFlipFromTop, animations: {
                j.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
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
        addNewTicketButton.layer.cornerRadius = addNewTicketButton.frame.width/2
        addNewTicketButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.firstTimeLoading = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
    
    func requestEntities(completionHandler: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            self.modalLoadingIndicatorView.show(inView: self.view, animated: true)
        }
        self.loadEntitiesBlock!() { entities, error in
            self.modalLoadingIndicatorView.dismiss()
            if let error = error {
                completionHandler(error)
                return
            }
            self.allTickets = entities!
            self.allTickets = self.allTickets.sorted{ $0.dftNumber! > $1.dftNumber!}
            self.tableView.reloadData()

            self.modalLoadingIndicatorView.dismiss()
            completionHandler(nil)

        }
    }
    @objc func refresh() {
    
        if self.modalLoadingIndicatorView.isAnimating == false {
        self.modalLoadingIndicatorView.show(inView: self.view)
        let oq = OperationQueue()
        oq.addOperation({
            self.requestEntities(completionHandler: {_ in
                OperationQueue.main.addOperation({
                    self.modalLoadingIndicatorView.dismiss()
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()})
                })
        })
    }
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
        if User.shared.role == UserRole.Reviewer{
       
            if self.navigationItem.searchController?.isActive == true {
                self.selectedTicketNumber = String(self.filteredTickets![indexPath.row].dftNumber!)
                self.selectedTicket = self.filteredTickets![indexPath.row]
                self.navigationItem.searchController?.isActive = false
                self.performSegue(withIdentifier: "TicketDetail", sender: self)
            }
            else{
                self.selectedTicketNumber = String(self.allTickets[indexPath.row].dftNumber!)
                self.selectedTicket = self.allTickets[indexPath.row]
                self.navigationItem.searchController = nil
                self.performSegue(withIdentifier: "TicketDetail", sender: self)
            }
//        else {
//            self.selectedTicketNumber = String(self.allTickets[indexPath.row].dftNumber!)
//            self.selectedTicket = self.allTickets[indexPath.row]
//            self.performSegue(withIdentifier: "TicketDetail", sender: self)
//            }
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
        self.navigationItem.rightBarButtonItem = self.searchButton
        self.navigationItem.searchController?.isActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateSearchResults(for: self.searchController)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}
extension DFTAllTicketsViewController : UISearchControllerDelegate{
    
}

