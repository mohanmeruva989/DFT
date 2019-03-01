//
//  AttestTicketViewModel.swift
//  DFT
//
//  Created by Mohan on 27/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
class AttestTicketViewModel {
    var tableViewModel : [CellModel]?
    
    init() {
            var model = [CellModel]()
        
        model.append(CellModel(labelName: "PO", inputType: .SearchPicker, identifier: "PO", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "WO", inputType: .SearchPicker, identifier: "WO", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "WBS", inputType: .SearchPicker, identifier: "WBS", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "Accounting Category", inputType: .SearchPicker, identifier: "AccountingCategory", dequeCell: "DFTCreateTableViewCell"))
            model.append(CellModel(labelName: "SES Approver", inputType: .ValuePicker, identifier: "SESApprover", dequeCell: "DFTCreateTableViewCell"))
        
            self.tableViewModel = model
    }
    
    
}
