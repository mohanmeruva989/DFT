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
    let urlSession = (UIApplication.shared.delegate as! AppDelegate).sapURLSession

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
    
        var data : Data?
        var url = try!
            URL(string: "https://mobile-hkea136m18.hana.ondemand.com/com.dft.xsodata/DFTSignature?$filter=reviewerId eq '\(String(describing: User.shared.id!))'&$format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        var urlRequest = try! URLRequest(url: url!, method: .get)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                let json : JSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! JSON
                print(json) as! JSON
                guard let d = json["d"] as? JSON else{
                    return
                }
                guard let results = d["results"] as? [JSON] else{
                    return
                }
                guard let sign = results.last as? JSON else{
                    return
                }
                self.signatureUrl = sign["digitalSignatureUrl"] as? String
                
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
