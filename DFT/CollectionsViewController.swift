//
// CollectionsViewController.swift
// DFT
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 08/02/19
//

import Foundation
import SAPFiori
import SAPOData

protocol EntityUpdaterDelegate {
    func entityHasChanged(_ entity: EntityValue?)
}

protocol EntitySetUpdaterDelegate {
    func entitySetHasChanged()
}

class CollectionsViewController: FUIFormTableViewController {
    private var collections = CollectionType.all

    // Variable to store the selected index path
    private var selectedIndex: IndexPath?

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private let okTitle = NSLocalizedString("keyOkButtonTitle",
                                            value: "OK",
                                            comment: "XBUT: Title of OK button.")

    var isPresentedInSplitView: Bool {
        return !(self.splitViewController?.isCollapsed ?? true)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 320, height: 480)

        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.makeSelection()
    }

    override func viewWillTransition(to _: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            let isNotInSplitView = !self.isPresentedInSplitView
            self.tableView.visibleCells.forEach { cell in
                // To refresh the disclosure indicator of each cell
                cell.accessoryType = isNotInSplitView ? .disclosureIndicator : .none
            }
            self.makeSelection()
        })
    }

    // MARK: - UITableViewDelegate

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.collections.count
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
        cell.headlineLabel.text = self.collections[indexPath.row].rawValue
        cell.accessoryType = !self.isPresentedInSplitView ? .disclosureIndicator : .none
        cell.isMomentarySelection = false
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.collectionSelected(at: indexPath)
    }

    // CollectionType selection helper

    private func collectionSelected(at: IndexPath) {
        // Load the EntityType specific ViewController from the specific storyboard
        var masterViewController: UIViewController!
        switch self.collections[at.row] {
        case .changeLogs:
            let changeLogsTypeStoryBoard = UIStoryboard(name: "ChangeLogsType", bundle: nil)
            masterViewController = changeLogsTypeStoryBoard.instantiateViewController(withIdentifier: "ChangeLogsTypeMaster")
            (masterViewController as! ChangeLogsTypeMasterViewController).entitySetName = "ChangeLogs"
            func fetchChangeLogs(_ completionHandler: @escaping ([ChangeLogsType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.getFieldTicketDetails!.fetchChangeLogs(matching: query) { changeLogs, error in
                        if error == nil {
                            completionHandler(changeLogs, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ChangeLogsTypeMasterViewController).loadEntitiesBlock = fetchChangeLogs
            masterViewController.navigationItem.title = "ChangeLogsType"
        case .dftHeader:
            let dFTHeaderTypeStoryBoard = UIStoryboard(name: "DFTHeaderType", bundle: nil)
            masterViewController = dFTHeaderTypeStoryBoard.instantiateViewController(withIdentifier: "DFTHeaderTypeMaster")
            (masterViewController as! DFTHeaderTypeMasterViewController).entitySetName = "DFTHeader"
            func fetchDFTHeader(_ completionHandler: @escaping ([DFTHeaderType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.getFieldTicketDetails!.fetchDFTHeader(matching: query) { dFTHeader, error in
                        if error == nil {
                            completionHandler(dFTHeader, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! DFTHeaderTypeMasterViewController).loadEntitiesBlock = fetchDFTHeader
            masterViewController.navigationItem.title = "DFTHeaderType"
        case .comments:
            let commentsTypeStoryBoard = UIStoryboard(name: "CommentsType", bundle: nil)
            masterViewController = commentsTypeStoryBoard.instantiateViewController(withIdentifier: "CommentsTypeMaster")
            (masterViewController as! CommentsTypeMasterViewController).entitySetName = "Comments"
            func fetchComments(_ completionHandler: @escaping ([CommentsType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.getFieldTicketDetails!.fetchComments(matching: query) { comments, error in
                        if error == nil {
                            completionHandler(comments, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! CommentsTypeMasterViewController).loadEntitiesBlock = fetchComments
            masterViewController.navigationItem.title = "CommentsType"
        case .attachments:
            let attachmentsTypeStoryBoard = UIStoryboard(name: "AttachmentsType", bundle: nil)
            masterViewController = attachmentsTypeStoryBoard.instantiateViewController(withIdentifier: "AttachmentsTypeMaster")
            (masterViewController as! AttachmentsTypeMasterViewController).entitySetName = "Attachments"
            func fetchAttachments(_ completionHandler: @escaping ([AttachmentsType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.getFieldTicketDetails!.fetchAttachments(matching: query) { attachments, error in
                        if error == nil {
                            completionHandler(attachments, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! AttachmentsTypeMasterViewController).loadEntitiesBlock = fetchAttachments
            masterViewController.navigationItem.title = "AttachmentsType"
        case .none:
            masterViewController = UIViewController()
        }

        // Load the NavigationController and present with the EntityType specific ViewController
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let rightNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "RightNavigationController") as! UINavigationController
        rightNavigationController.viewControllers = [masterViewController]
        self.splitViewController?.showDetailViewController(rightNavigationController, sender: nil)
    }

    // MARK: - Handle highlighting of selected cell

    private func makeSelection() {
        if let selectedIndex = selectedIndex {
            self.tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
            self.tableView.scrollToRow(at: selectedIndex, at: .none, animated: true)
        } else {
            self.selectDefault()
        }
    }

    private func selectDefault() {
        // Automatically select first element if we have two panels (iPhone plus and iPad only)
        if self.splitViewController!.isCollapsed || self.appDelegate.getFieldTicketDetails == nil {
            return
        }
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        self.collectionSelected(at: indexPath)
    }
}
