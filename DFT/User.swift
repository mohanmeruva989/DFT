//
//  User.swift
//  DFT
//
//  Created by Mohan on 16/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
import UIKit
class User {
    
    static let shared = User()
    
    var fullName : String?
    var emailId : String?
    var id : String?
    var role : UserRole?
    var signatureUrl : String?

    init() {}
    func setUserDetails(json : JSON) {
        let names = json["name"] as! JSON
        self.fullName = (names["givenName"] as! String) + " " + (names["familyName"] as! String)
        
        let temp = json["emails"] as? [JSON]
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
        if self.role == UserRole.Reviewer && self.id != nil{
            self.getSignatureUrl()
        }    }
    
    func getSignatureUrl() {
    
        let url = try!
            URL(string: "https://mobile-hkea136m18.hana.ondemand.com/com.dft.xsodata/getSignature.xsodata/DFTSignature?$filter=reviewerId eq '\(String(describing: User.shared.id!))'&$format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let urlRequest = try! URLRequest(url: url!, method: .get)
        
        let dataTask = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                let json : JSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                print(json)
                guard let d = json["d"] as? JSON else{
                    return
                }
                guard let results = d["results"] as? [JSON] else{
                    return
                }
                guard let sign = results.last else{
                    return
                }
                
                let docID: String = URL(string: sign["digitalSignatureUrl"] as! String)!.lastPathComponent
                let absUrl: String =  "https://docservicesx5qv5zg6ns.hana.ondemand.com/AppDownload/inctureDft/documents/download/" + docID
                User.shared.signatureUrl = absUrl
                self.signatureUrl = absUrl
            } catch let jsonError as NSError {
                print(jsonError.userInfo)
            }
            
            guard let _ = data, error == nil else {
                print("Error in PostinG create payload")
                return }
            do {
                print(response)
            } catch let error as NSError {
                print(error)
            }
        }
        dataTask.resume()
        
    }
}
enum UserRole {
    case ServiceProvider
    case Reviewer
}
