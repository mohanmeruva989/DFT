//
//  NetworkManger.swift
//  DFT
//
//  Created by Mohan on 26/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import Alamofire
class DFTNetworkManager {
    let baseUrl : String  = BaseUrl.InctureTenant.rawValue
    static let shared = DFTNetworkManager()
    var sapUrlSession : SAPURLSession!
    init() {
        
    }
}
// MARK: - Rules API Calls
extension DFTNetworkManager{
//    func fetchCSRFToken(){
//        guard let url = URL(string: self.baseUrl + "com.incture.rules/rules-service/v1/rules/xsrf-token")else {
//            return
//        }
//
//        let header = [ "X-CSRF-Token" : "Fetch"]
//        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
//            .responseString{ response in
//
//                    print(response.response?.allHeaderFields)
//                    let _  = response.response?.allHeaderFields["x-csrf-token"] as! String?
//
//        }
//
//        let headers = [
//            "x-csrf-token": "Fetch",
//            "cache-control": "no-cache",
//            "postman-token": "3349a38d-a53b-fd10-3823-cc9f6682b633"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://bpmrulesruntimerules-hkea136m18.hana.ondemand.com/rules-service/v1/rules/xsrf-token")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//        })
//
//        dataTask.resume()
//
//
//
//
//
//
//
//
//
//        var urlRequest = try! URLRequest(url: url, method: .get)
//        urlRequest.httpMethod = "GET"
//        urlRequest.addValue("Fetch", forHTTPHeaderField: "X-CSRF-Token")
//        _ = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
//            print(response)
//            if let error = error{
//                print(error.localizedDescription)
//            }
//            if let urlResp = response as? HTTPURLResponse  {
//                print("\(urlResp.allHeaderFields["x-csrf-token"] as? String)")
//                let token = urlResp.allHeaderFields["x-csrf-token"] as? String
//            }
//
//            else if let data = data , let response = response as? HTTPURLResponse, response.statusCode == 200{
//                let json = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//                    print(json)}
//        }.resume()
////    }
//    func getallDepartments(){
//        guard let url = URL(string: "https://bpmrulesruntimerules-hkea136m18.hana.ondemand.com/rules-service/rest/v1/rule-services/java/DFT_Rules/getAllDepartments")else {
//            return
//        }
//
//        var urlRequest = try! URLRequest(url: url, method: .get)
//
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.addValue("5A493F4D9349CD4D7301F76A32616D1A", forHTTPHeaderField: "x-csrf-token")
//        _ = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
//            print(response)
//            if let error = error{
//                print(error.localizedDescription)
//            }
////            if let urlResp = response as? HTTPURLResponse  {
////                print("\(urlResp.allHeaderFields["x-csrf-token"] as? String)")
////                let token = urlResp.allHeaderFields["x-csrf-token"] as! String
////            }
////
////            else if let data = data , let response = response as? HTTPURLResponse, response.statusCode == 200{
////                let json = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
////
////                print(json)}
//            }.resume()
//    }
}

enum BaseUrl : String {
    case InctureTenant = "https://mobile-hkea136m18.hana.ondemand.com/"
}
