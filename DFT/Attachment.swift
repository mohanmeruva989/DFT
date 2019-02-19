//
//  Attachment.swift
//  DFT
//
//  Created by Mohan on 19/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//


import Foundation
class Attachment {
    
    var attachmentName : String = ""
    var attachmentLength : Int  = 0
    var attachmentLengthFromService : String = ""
    var attachmentContent : String = ""
    var attachmentType : String = ""
    var createdOn : String = ""
    var ServiceProviderId : String = ""
    var ticketNumber : String = ""
    var attachmentID : String = ""
    var createdBy : String = ""
    var updatedBy : String = ""
    var updatedOn : String = ""
    var sharepointUrl : String = ""
    var createdByName : String = ""
    var create_Date : String = ""
    var deleteFlag : String = ""
    
    //Document service Variables
    var documentId : String?
    var attachmentUrl : String?
    var attachmentData : Data?
    
    
}
