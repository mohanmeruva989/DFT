//
// CollectionType.swift
// DFT
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 08/02/19
//

import Foundation

enum CollectionType: String {
    case changeLogs = "ChangeLogs"
    case dftHeader = "DFTHeader"
    case comments = "Comments"
    case attachments = "Attachments"
    case none = ""

    static let all = [
        changeLogs, dftHeader, comments, attachments,
    ]
}
