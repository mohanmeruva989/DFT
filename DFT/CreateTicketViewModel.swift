//
//  CreateTicketViewModel.swift
//  DFT
//
//  Created by Mohan on 14/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]
class CreateTicketViewModel {
    var tableViewModel : [CellModel]?
    
    init(DFTType : DFTType) {
        switch DFTType {
        case .GeneralDFT:
            var model = [CellModel]()
            model.append(CellModel(labelName: "Vendor Ref No", inputType: .TextField, identifier: "VendorRefNo", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "Department", inputType: .ValuePicker, identifier: "Department", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "Location", inputType: .TextField, identifier: "Location", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "MurphyReviewer", inputType: .TextField, identifier: "MurphyReviewer", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "StartDetails", inputType: .TextField, identifier: "StartDetails", dequeCell: "DFTDateTimeTableViewCell"))
            model.append(CellModel(labelName: "EndDetails", inputType: .TextField, identifier: "EndDetails", dequeCell: "DFTDateTimeTableViewCell"))

            self.tableViewModel = model
        case .Attachment:
            var model = [CellModel]()
            model.append(CellModel(labelName: "Comments", inputType: .TextView, identifier: "Comments", dequeCell: "DFTCommentsTableViewCell"))
            model.append(CellModel(labelName: "GalleryView", inputType: .ImagePicker, identifier: "GalleryView", dequeCell: "DFTGalleryTableViewCell"))
            self.tableViewModel = model
        default:
            print("Invalid DFT Type received while creating CreateTicketViewModel")
        }
    }


}
class CellModel {
    var labelName : String
    var inputType : CellInputType
    var identifier : String
    var dequeCell : String
    init(labelName : String , inputType : CellInputType , identifier : String , dequeCell : String) {
        self.labelName = labelName
        self.inputType = inputType
        self.identifier = identifier
        self.dequeCell = dequeCell
    }
}



enum CellInputType {
    case TextField
    case ValuePicker
    case TextView
    case DatePicker
    case ImagePicker
}
enum DFTType {
    case GeneralDFT
    case SaltwaterDisposal
    case Attachment
}
