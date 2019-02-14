//
// DFTHeaderTypeDetailViewController.swift
// DFT
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 08/02/19
//

import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData

class DFTHeaderTypeDetailViewController: FUIFormTableViewController, SAPFioriLoadingIndicator {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var getFieldTicketDetails: GetFieldTicketDetails<OnlineODataProvider> {
        return self.appDelegate.getFieldTicketDetails
    }

    private var validity = [String: Bool]()
    private var _entity: DFTHeaderType?
    var allowsEditableCells = false
    var entity: DFTHeaderType {
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

    private let logger = Logger.shared(named: "DFTHeaderTypeMasterViewControllerLogger")
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
            let detailViewController = dest.viewControllers[0] as! DFTHeaderTypeDetailViewController
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
            return self.cellForDftNumber(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.dftNumber)
        case 1:
            return self.cellForPoNumber(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.poNumber)
        case 2:
            return self.cellForVendorAdminID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.vendorAdminID)
        case 3:
            return self.cellForVendorID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.vendorID)
        case 4:
            return self.cellForVendorName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.vendorName)
        case 5:
            return self.cellForVendorAddress(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.vendorAddress)
        case 6:
            return self.cellForAribaSesNo(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.aribaSesNo)
        case 7:
            return self.cellForServiceProviderMail(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.serviceProviderMail)
        case 8:
            return self.cellForServiceProviderID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.serviceProviderID)
        case 9:
            return self.cellForServiceProviderName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.serviceProviderName)
        case 10:
            return self.cellForReviewerID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.reviewerID)
        case 11:
            return self.cellForReviewerName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.reviewerName)
        case 12:
            return self.cellForReviewerEmail(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.reviewerEmail)
        case 13:
            return self.cellForSesApproverName(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.sesApproverName)
        case 14:
            return self.cellForSesApproverEmail(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.sesApproverEmail)
        case 15:
            return self.cellForDepartment(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.department)
        case 16:
            return self.cellForLocation(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.location)
        case 17:
            return self.cellForStartDate(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.startDate)
        case 18:
            return self.cellForEndDate(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.endDate)
        case 19:
            return self.cellForAccountingCategory(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.accountingCategory)
        case 20:
            return self.cellForCostCenter(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.costCenter)
        case 21:
            return self.cellForSesNumber(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.sesNumber)
        case 22:
            return self.cellForWorkOrderNo(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.workOrderNo)
        case 23:
            return self.cellForSignatureVersion(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.signatureVersion)
        case 24:
            return self.cellForWbsElement(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.wbsElement)
        case 25:
            return self.cellForDeviceType(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.deviceType)
        case 26:
            return self.cellForDeviceID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.deviceID)
        case 27:
            return self.cellForStatus(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.status)
        case 28:
            return self.cellForCreatedBy(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.createdBy)
        case 29:
            return self.cellForCreatedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.createdOn)
        case 30:
            return self.cellForUpdatedBy(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.updatedBy)
        case 31:
            return self.cellForUpdatedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.updatedOn)
        case 32:
            return self.cellForVendorRefNumber(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.vendorRefNumber)
        case 33:
            return self.cellForReviewedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.reviewedOn)
        case 34:
            return self.cellForReviewedBy(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.reviewedBy)
        case 35:
            return self.cellForCompletedBy(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.completedBy)
        case 36:
            return self.cellForCompletedOn(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.completedOn)
        case 37:
            return self.cellForWell(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.well)
        case 38:
            return self.cellForField(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.field)
        case 39:
            return self.cellForFacility(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.facility)
        case 40:
            return self.cellForWellPad(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.wellPad)
        case 41:
            return self.cellForOwnerID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.ownerID)
        case 42:
            return self.cellForWfInstanceID(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: DFTHeaderType.wfInstanceID)
        case 43:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "Comments"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        case 44:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "ChangeLogs"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        case 45:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "Attachments"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 46
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 43 {
            return true
        }
        return false
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.preventNavigationLoop {
            return
        }
        switch indexPath.row {
        case 43:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "CommentsType", bundle: nil)
            var masterViewController = destinationStoryBoard.instantiateViewController(withIdentifier: "CommentsTypeMaster")
            func loadProperty(_ completionHandler: @escaping ([CommentsType]?, Error?) -> Void) {
                self.getFieldTicketDetails.loadProperty(DFTHeaderType.comments, into: self.entity) { error in
                    self.hideFioriLoadingIndicator()
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    completionHandler(self.entity.comments, nil)
                }
            }
            (masterViewController as! CommentsTypeMasterViewController).loadEntitiesBlock = loadProperty
            masterViewController.navigationItem.title = "Comments"
            (masterViewController as! CommentsTypeMasterViewController).preventNavigationLoop = true
            self.navigationController?.pushViewController(masterViewController, animated: true)
        case 44:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "ChangeLogsType", bundle: nil)
            var masterViewController = destinationStoryBoard.instantiateViewController(withIdentifier: "ChangeLogsTypeMaster")
            func loadProperty(_ completionHandler: @escaping ([ChangeLogsType]?, Error?) -> Void) {
                self.getFieldTicketDetails.loadProperty(DFTHeaderType.changeLogs, into: self.entity) { error in
                    self.hideFioriLoadingIndicator()
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    completionHandler(self.entity.changeLogs, nil)
                }
            }
            (masterViewController as! ChangeLogsTypeMasterViewController).loadEntitiesBlock = loadProperty
            masterViewController.navigationItem.title = "ChangeLogs"
            (masterViewController as! ChangeLogsTypeMasterViewController).preventNavigationLoop = true
            self.navigationController?.pushViewController(masterViewController, animated: true)
        case 45:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "AttachmentsType", bundle: nil)
            var masterViewController = destinationStoryBoard.instantiateViewController(withIdentifier: "AttachmentsTypeMaster")
            func loadProperty(_ completionHandler: @escaping ([AttachmentsType]?, Error?) -> Void) {
                self.getFieldTicketDetails.loadProperty(DFTHeaderType.attachments, into: self.entity) { error in
                    self.hideFioriLoadingIndicator()
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    completionHandler(self.entity.attachments, nil)
                }
            }
            (masterViewController as! AttachmentsTypeMasterViewController).loadEntitiesBlock = loadProperty
            masterViewController.navigationItem.title = "Attachments"
            (masterViewController as! AttachmentsTypeMasterViewController).preventNavigationLoop = true
            self.navigationController?.pushViewController(masterViewController, animated: true)
        default:
            return
        }
    }

    // MARK: - OData property specific cell creators

    private func cellForDftNumber(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
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

    private func cellForPoNumber(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.poNumber {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.poNumber = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.poNumber.isOptional || newValue != "" {
                    currentEntity.poNumber = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForVendorAdminID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendorAdminID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendorAdminID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.vendorAdminID.isOptional || newValue != "" {
                    currentEntity.vendorAdminID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForVendorID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendorID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendorID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.vendorID.isOptional || newValue != "" {
                    currentEntity.vendorID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForVendorName(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendorName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendorName = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.vendorName.isOptional || newValue != "" {
                    currentEntity.vendorName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForVendorAddress(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendorAddress {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendorAddress = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.vendorAddress.isOptional || newValue != "" {
                    currentEntity.vendorAddress = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForAribaSesNo(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.aribaSesNo {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.aribaSesNo = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.aribaSesNo.isOptional || newValue != "" {
                    currentEntity.aribaSesNo = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForServiceProviderMail(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.serviceProviderMail {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.serviceProviderMail = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.serviceProviderMail.isOptional || newValue != "" {
                    currentEntity.serviceProviderMail = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForServiceProviderID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.serviceProviderID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.serviceProviderID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.serviceProviderID.isOptional || newValue != "" {
                    currentEntity.serviceProviderID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForServiceProviderName(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.serviceProviderName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.serviceProviderName = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.serviceProviderName.isOptional || newValue != "" {
                    currentEntity.serviceProviderName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReviewerID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reviewerID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reviewerID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.reviewerID.isOptional || newValue != "" {
                    currentEntity.reviewerID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReviewerName(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reviewerName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reviewerName = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.reviewerName.isOptional || newValue != "" {
                    currentEntity.reviewerName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReviewerEmail(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reviewerEmail {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reviewerEmail = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.reviewerEmail.isOptional || newValue != "" {
                    currentEntity.reviewerEmail = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForSesApproverName(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.sesApproverName {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.sesApproverName = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.sesApproverName.isOptional || newValue != "" {
                    currentEntity.sesApproverName = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForSesApproverEmail(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.sesApproverEmail {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.sesApproverEmail = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.sesApproverEmail.isOptional || newValue != "" {
                    currentEntity.sesApproverEmail = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDepartment(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.department {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.department = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.department.isOptional || newValue != "" {
                    currentEntity.department = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForLocation(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.location {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.location = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.location.isOptional || newValue != "" {
                    currentEntity.location = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForStartDate(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.startDate {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.startDate = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.startDate = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForEndDate(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.endDate {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.endDate = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.endDate = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForAccountingCategory(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.accountingCategory {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.accountingCategory = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.accountingCategory.isOptional || newValue != "" {
                    currentEntity.accountingCategory = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCostCenter(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.costCenter {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.costCenter = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.costCenter.isOptional || newValue != "" {
                    currentEntity.costCenter = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForSesNumber(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.sesNumber {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.sesNumber = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.sesNumber.isOptional || newValue != "" {
                    currentEntity.sesNumber = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForWorkOrderNo(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.workOrderNo {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.workOrderNo = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.workOrderNo.isOptional || newValue != "" {
                    currentEntity.workOrderNo = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForSignatureVersion(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.signatureVersion {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.signatureVersion = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.signatureVersion.isOptional || newValue != "" {
                    currentEntity.signatureVersion = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForWbsElement(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.wbsElement {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.wbsElement = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.wbsElement.isOptional || newValue != "" {
                    currentEntity.wbsElement = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDeviceType(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.deviceType {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.deviceType = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.deviceType.isOptional || newValue != "" {
                    currentEntity.deviceType = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDeviceID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.deviceID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.deviceID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.deviceID.isOptional || newValue != "" {
                    currentEntity.deviceID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForStatus(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.status {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.status = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.status.isOptional || newValue != "" {
                    currentEntity.status = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCreatedBy(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.createdBy {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.createdBy = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.createdBy.isOptional || newValue != "" {
                    currentEntity.createdBy = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCreatedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
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

    private func cellForUpdatedBy(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.updatedBy {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.updatedBy = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.updatedBy.isOptional || newValue != "" {
                    currentEntity.updatedBy = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForUpdatedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
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

    private func cellForVendorRefNumber(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendorRefNumber {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendorRefNumber = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.vendorRefNumber.isOptional || newValue != "" {
                    currentEntity.vendorRefNumber = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReviewedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reviewedOn {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reviewedOn = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.reviewedOn = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReviewedBy(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reviewedBy {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reviewedBy = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.reviewedBy.isOptional || newValue != "" {
                    currentEntity.reviewedBy = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCompletedBy(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.completedBy {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.completedBy = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.completedBy.isOptional || newValue != "" {
                    currentEntity.completedBy = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCompletedOn(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.completedOn {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.completedOn = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.completedOn = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForWell(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.well {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.well = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.well.isOptional || newValue != "" {
                    currentEntity.well = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForField(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.field {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.field = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.field.isOptional || newValue != "" {
                    currentEntity.field = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForFacility(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.facility {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.facility = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.facility.isOptional || newValue != "" {
                    currentEntity.facility = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForWellPad(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.wellPad {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.wellPad = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.wellPad.isOptional || newValue != "" {
                    currentEntity.wellPad = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForOwnerID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.ownerID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.ownerID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.ownerID.isOptional || newValue != "" {
                    currentEntity.ownerID = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForWfInstanceID(tableView: UITableView, indexPath: IndexPath, currentEntity: DFTHeaderType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.wfInstanceID {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.wfInstanceID = nil
                isNewValueValid = true
            } else {
                if DFTHeaderType.wfInstanceID.isOptional || newValue != "" {
                    currentEntity.wfInstanceID = newValue
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

    func createEntityWithDefaultValues() -> DFTHeaderType {
        let newEntity = DFTHeaderType()

        // Key properties without default value should be invalid by default for Create scenario
        if newEntity.dftNumber == nil {
            self.validity["dftNumber"] = false
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

extension DFTHeaderTypeDetailViewController: EntityUpdaterDelegate {
    func entityHasChanged(_ entityValue: EntityValue?) {
        if let entity = entityValue {
            let currentEntity = entity as! DFTHeaderType
            self.entity = currentEntity
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
