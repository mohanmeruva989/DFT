//
// AttachmentsTypeDetailViewController.swift
// DFT
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 08/02/19
//

import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData

class AttachmentsTypeDetailViewController: FUIFormTableViewController, SAPFioriLoadingIndicator {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var getFieldTicketDetails: GetFieldTicketDetails<OnlineODataProvider> {
        return self.appDelegate.getFieldTicketDetails
    }

    private var validity = [String: Bool]()
    private var _entity: AttachmentsType?
    var allowsEditableCells = false
    var entity: AttachmentsType {
        get {
            if self._entity == nil {
                self._entity = self.createEntityWithDefaultValues()
            }
            return self._entity!
        }
        set {
            self._entity = newValue
        }
    }

    private let logger = Logger.shared(named: "AttachmentsTypeMasterViewControllerLogger")
    var loadingIndicator: FUILoadingIndicatorView?
    var entityUpdater: EntityUpdaterDelegate?
    var tableUpdater: EntitySetUpdaterDelegate?
    private let okTitle = NSLocalizedString("keyOkButtonTitle",
                                            value: "OK",
                                            comment: "XBUT: Title of OK button.")
    var preventNavigationLoop = false
    var entitySetName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "updateEntity" {
            // Show the Detail view with the current entity, where the properties scan be edited and updated
            self.logger.info("Showing a view to update the selected entity.")
            let dest = segue.destination as! UINavigationController
            let detailViewController = dest.viewControllers[0] as! AttachmentsTypeDetailViewController
            detailViewController.title = NSLocalizedString("keyUpdateEntityTitle", value: "Update Entity", comment: "XTIT: Title of update selected entity screen.")
            detailViewController.entity = self.entity
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: detailViewController, action: #selector(detailViewController.updateEntity))
            detailViewController.navigationItem.rightBarButtonItem = doneButton
            let cancelButton = UIBarButtonItem(title: NSLocalizedString("keyCancelButtonToGoPreviousScreen", value: "Cancel", comment: "XBUT: Title of Cancel button."), style: .plain, target: detailViewController, action: #selector(detailViewController.cancel))
            detailViewController.navigationItem.leftBarButtonItem = cancelButton
            detailViewController.allowsEditableCells = true
            detailViewController.entityUpdater = self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.cellForAttachmentID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.attachmentID)
        case 1:
            return self.cellForDftNumber(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.dftNumber)
        case 2:
            return self.cellForAttachmentName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.attachmentName)
        case 3:
            return self.cellForDftAttachmentType(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.dftAttachmentType)
        case 4:
            return self.cellForCreatedByName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.createdByName)
        case 5:
            return self.cellForCreatedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.createdOn)
        case 6:
            return self.cellForUpdatedByName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.updatedByName)
        case 7:
            return self.cellForUpdatedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.updatedOn)
        case 8:
            return self.cellForAttachmentUrl(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: AttachmentsType.attachmentUrl)
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 9
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 9 {
            return true
        }
        return false
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.preventNavigationLoop {
            return
        }
        switch indexPath.row {
        default:
            return
        }
    }

    // MARK: - OData property specific cell creators

    private func cellForAttachmentID(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.attachmentID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.attachmentID = nil
                isNewValueValid = true
            } else {
                if let validValue = Int(newValue) {
                    currentEntity.attachmentID = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDftNumber(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.dftNumber {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.dftNumber = nil
                isNewValueValid = true
            } else {
                if let validValue = Int(newValue) {
                    currentEntity.dftNumber = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForAttachmentName(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.attachmentName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.attachmentName = nil
                isNewValueValid = true
            } else {
                if AttachmentsType.attachmentName.isOptional || newValue != "" {
                    currentEntity.attachmentName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDftAttachmentType(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.dftAttachmentType {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.dftAttachmentType = nil
                isNewValueValid = true
            } else {
                if AttachmentsType.dftAttachmentType.isOptional || newValue != "" {
                    currentEntity.dftAttachmentType = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCreatedByName(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.createdByName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.createdByName = nil
                isNewValueValid = true
            } else {
                if AttachmentsType.createdByName.isOptional || newValue != "" {
                    currentEntity.createdByName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCreatedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.createdOn {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.createdOn = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.createdOn = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForUpdatedByName(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.updatedByName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.updatedByName = nil
                isNewValueValid = true
            } else {
                if AttachmentsType.updatedByName.isOptional || newValue != "" {
                    currentEntity.updatedByName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForUpdatedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.updatedOn {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.updatedOn = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.updatedOn = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForAttachmentUrl(tableView: UITableView, indexPath: IndexPath, currentEntity: AttachmentsType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.attachmentUrl {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.attachmentUrl = nil
                isNewValueValid = true
            } else {
                if AttachmentsType.attachmentUrl.isOptional || newValue != "" {
                    currentEntity.attachmentUrl = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    // MARK: - OData functionalities

    @objc func createEntity() {
        self.showFioriLoadingIndicator()
        self.view.endEditing(true)
        self.logger.info("Creating entity in backend.")
        self.getFieldTicketDetails.createEntity(self.entity) { error in
            self.hideFioriLoadingIndicator()
            if let error = error {
                self.logger.error("Create entry failed. Error: \(error)", error: error)
                let alertController = UIAlertController(title: NSLocalizedString("keyErrorEntityCreationTitle", value: "Create entry failed", comment: "XTIT: Title of alert message about entity creation error."), message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                OperationQueue.main.addOperation({
                    // Present the alertController
                    self.present(alertController, animated: true)
                })
                return
            }
            self.logger.info("Create entry finished successfully.")
            OperationQueue.main.addOperation({
                self.dismiss(animated: true) {
                    FUIToastMessage.show(message: NSLocalizedString("keyEntityCreationBody", value: "Created", comment: "XMSG: Title of alert message about successful entity creation."))
                    self.tableUpdater?.entitySetHasChanged()
                }
            })
        }
    }

    func createEntityWithDefaultValues() -> AttachmentsType {
        let newEntity = AttachmentsType()

        // Key properties without default value should be invalid by default for Create scenario
        if newEntity.attachmentID == nil {
            self.validity["attachmentId"] = false
        }
        self.barButtonShouldBeEnabled()
        return newEntity
    }

    @objc func updateEntity(_: AnyObject) {
        self.showFioriLoadingIndicator()
        self.view.endEditing(true)
        self.logger.info("Updating entity in backend.")
        self.getFieldTicketDetails.updateEntity(self.entity) { error in
            self.hideFioriLoadingIndicator()
            if let error = error {
                self.logger.error("Update entry failed. Error: \(error)", error: error)
                let alertController = UIAlertController(title: NSLocalizedString("keyErrorEntityUpdateTitle", value: "Update entry failed", comment: "XTIT: Title of alert message about entity update failure."), message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                OperationQueue.main.addOperation({
                    // Present the alertController
                    self.present(alertController, animated: true)
                })
                return
            }
            self.logger.info("Update entry finished successfully.")
            OperationQueue.main.addOperation({
                self.dismiss(animated: true) {
                    FUIToastMessage.show(message: NSLocalizedString("keyUpdateEntityFinishedTitle", value: "Updated", comment: "XTIT: Title of alert message about successful entity update."))
                    self.entityUpdater?.entityHasChanged(self.entity)
                }
            })
        }
    }

    // MARK: - other logic, helper

    @objc func cancel() {
        OperationQueue.main.addOperation({
            self.dismiss(animated: true)
        })
    }

    // Check if all text fields are valid
    private func barButtonShouldBeEnabled() {
        let anyFieldInvalid = self.validity.values.first { field in
            return field == false
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = anyFieldInvalid == nil
    }
}

extension AttachmentsTypeDetailViewController: EntityUpdaterDelegate {
    func entityHasChanged(_ entityValue: EntityValue?) {
        if let entity = entityValue {
            let currentEntity = entity as! AttachmentsType
            self.entity = currentEntity
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
