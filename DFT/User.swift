//
//  User.swift
//  DFT
//
//  Created by Mohan on 16/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
class User {
    
    static let shared = User()
    
    var fullName : String?
    var emailId : String?
    var id : String?
    var role : UserRole?
    init() {}
    func setUserDetails(json : JSON) {
        self.fullName = json[""] as? String
        let temp = json["emailid"] as? [JSON]
        self.emailId = temp?[0]["value"] as? String
        self.id = json["id"] as? String
        let roles = json["groups"] as? [JSON]
        for each in roles!{
            let role =  each["value"] as! String
            if role.contains("DFTReviewer"){
                self.role = UserRole.Reviewer
                break
            }
            else{
                self.role = UserRole.ServiceProvider
            }
        }
        //        self.role =
    }
}
enum UserRole {
    case ServiceProvider
    case Reviewer
}
