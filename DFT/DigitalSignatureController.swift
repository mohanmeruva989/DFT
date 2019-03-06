//
//  DigitalSignatureController.swift
//  MurphyDFT-Final
//
//  Created by Soumya Singh on 10/02/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import Alamofire
import SAPFiori

class DigitalSignatureController: UIViewController {

    @IBOutlet var SignatureView: YPDrawSignatureView!
    @IBOutlet var legalDisclaimerView: UITextView!
    @IBOutlet var floatingButton: UIButton!
    
    var modalLoadingIndicatorView = FUIModalLoadingIndicatorView()
    var csrfToken : String?
    var isUpdate : Bool?
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        floatingButton.layer.cornerRadius = 30
//        let htmlText = "<ul style = 'color : #868686 ; font-size : 14;'><li><i>All Commercial Terms are to be in accordance to Murphy Oil MSA and originating Work Order.</i></li><li><i>Field/Wellsite Operations Stamp is a confirmation of services/materials received only.</i></li></ul>"
//        let attrStr = try! NSAttributedString(
//            data: htmlText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
//            options: [ .documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil)
//        legalDisclaimerView.attributedText = attrStr
//

        // Do any additional setup after loading the view.
    }
    func createNavBar() {
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Digital Signature"
        let doneItem = UIBarButtonItem.init(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.saveSignature))
        let backItem = UIBarButtonItem.init(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissScreen))
        navigationItem.rightBarButtonItem = doneItem
        navigationItem.leftBarButtonItem = backItem
        
    }
    
    func loaderStart()
    {
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        indicator.bounds = UIScreen.main.bounds
        UIApplication.shared.keyWindow!.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func loaderStop()
    {
        indicator.stopAnimating()
    }

    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.SignatureView.clear()
    }
    
    
    
//    func getCSRFforSignaturePost(signatureImage : UIImage)
//    {
//        let header = [ "x-csrf-token" : "fetch"]
//
//        Alamofire.request("\(BaseUrl.apiURL)/com.OData.dest/Dft_SignatureSet", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
//            .responseString{ response in
//
//                if ConnectionCheck.isConnectedToNetwork(){
//                    self.csrfToken = response.response?.allHeaderFields["x-csrf-token"] as! String?
//                    if self.csrfToken != nil{
//                        self.postDigitalSignature(signatureImage : signatureImage)
//                    }
//                    else{
//
//                        let alertController = UIAlertController.init(title: "", message:"CSRF fetch failed.Signature was not updated.Please retry." , preferredStyle: UIAlertControllerStyle.alert)
//                        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
//                        alertController.addAction(okAction)
//                        self.present(alertController, animated: true, completion: nil)
//                    }
//                }
//                else{
//                    let alertController = UIAlertController.init(title: "", message:"Internet Connection is not available!" , preferredStyle: UIAlertControllerStyle.alert)
//                    let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
//                    alertController.addAction(okAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
//        }
//    }
    
    func postDigitalSignature()
    {
        
        do{
            var data : Data?
            let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.incture.basexsodata/createSignature.xsjs".asURL()
            DispatchQueue.main.async {
                self.modalLoadingIndicatorView.show(inView: self.view)
            }
            let payload :JSON = [
                "reviewerId": User.shared.id ?? "",
                "version": "",
                "digitalSignatureUrl": User.shared.signatureUrl ?? "",
                "mimeType": "image/jpeg"
            ]
            var urlRequest = try! URLRequest(url: url, method: .post)
            do {
                data = try JSONSerialization.data(withJSONObject: payload, options: [])
                let sd = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print("****param****")
                print(sd.printJson())
                print("****param end****")            } catch let jsonError as NSError {
                    print(jsonError.userInfo)
            }
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data!
            let dataTask = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    self.modalLoadingIndicatorView.dismiss()
                }
             
                
                do {
                    let json : [String : Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                    //                    print(json)
                    
                        if let documentDetailDto = json["documentDetailDto"] as? [String : Any]{
                            print(User.shared.signatureUrl)
                        
                    }
                    DispatchQueue.main.async {
                        self.dismissScreen()
                    }
                    
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
    
    
    
    
    // Function for saving signature
    @objc func saveSignature() {
        // Getting the Signature Image from self.drawSignatureView using the method getSignature().
        if let signatureImage = self.SignatureView.getSignature(scale: 10) {
            
            
//            
//            let renderer = UIGraphicsImageRenderer(size: textSize)
//            let image = renderer.image(actions: { context in
//                let rect = CGRect(origin: .zero, size: textSize)
//                text.draw(in: rect, withAttributes: attributes)
//            })
//            var attachImage = UIImage(named : "Dash2")
//
//            var finalMixedImage = getMixedImg(image1 : attachImage!, image2: signatureImage)
            
            
//            loaderStart()
            self.callDocumentService(signatureImage: signatureImage)
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            // UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.SignatureView.clear()
        }
    }
    
    @objc func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    func callDocumentService(signatureImage: UIImage){
        let imageData: Data = signatureImage.jpegData(compressionQuality: 0.3) as! Data
        let imageSize = imageData.count
        let value = ByteCountFormatter.string(fromByteCount: Int64(imageSize), countStyle: .file)
        print(value)
        let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
        let documentInfo : [[String : Any]] =
                [[
                    "folderName": "DummyFolder",
                    "fileType" : "image/jpeg" ,
                    "fileName" : User.shared.id ?? "" + "DigiSign" ,
                    "fileContent" : strBase64,
                    "country": "",
                    "region": "",
                    "project": "",
                    "module": "",
                    "createdBy": "",
                    "createdOn": "",
                    "program": "",
                    "appId": "",
                    "transactionNumber": "",
                    "docCreationDate": "",
                    "docCreatedBy": ""
                    
            ]]
        let payload : [String : Any] = ["documentDetailDtoList" : documentInfo]
        
        
        do{
            var data : Data?
            let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.incture.documentService/upload".asURL()
            self.modalLoadingIndicatorView.show(inView: self.view)
            var urlRequest = try! URLRequest(url: url, method: .put)
            do {
                data = try JSONSerialization.data(withJSONObject: payload, options: [])
                let sd = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print("****param****")
                //                print(sd.printJson())
                print("****param end****")            } catch let jsonError as NSError {
                    print(jsonError.userInfo)
            }
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data!
            let dataTask = DFTNetworkManager.shared.sapUrlSession.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    self.modalLoadingIndicatorView.dismiss()
                }
                
                do {
                    let json : [[String : Any]] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String : Any]]
                    //                    print(json)
                    
                    for each in json{
                        if let documentDetailDto = each["documentDetailDto"] as? [String : Any]{
                                    User.shared.signatureUrl = "https://docservicesx5qv5zg6ns.hana.ondemand.com/AppDownload/inctureDft/documents/download/" + (documentDetailDto["documentId"] as! String)
                            print(User.shared.signatureUrl)
                        }
                    }
                    self.postDigitalSignature()
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
    
    @objc func decision(){
        if isUpdate!{
            
            self.dismissScreen()
        }
        else{
            
//            self.firstTimeCall()
        }
    }
    
//    func firstTimeCall(){
//        
//        self.dismissScreen()
////        dashBoardSender?.backFromSignaturescreen()
//        
//    }
    
//    func getSignatureAvailability() {
//        
//        let id = UserDefaults.standard.string(forKey: "id")
//        let url = "\(BaseUrl.apiURL)/com.OData.dest/Dft_SignatureSet(ApproverId='122')?$format=json"
//        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        Alamofire.request(encodedUrl!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
//            .responseJSON{ response in
//                
//                
//                print(response.result.value)
//                switch response.result {
//                case .success(let JSON):
//                    if let jsonDict = JSON as? NSDictionary {
//                        if let d = jsonDict.value(forKey: "d") as? NSDictionary{
//                            let base64String = d.value(forKey: "DigitalSignature") as? String
//                            
//                        }
//                        
//                        
//                    }
//                case .failure(let error):
//                    let message = error.localizedDescription
//                    let alertController = UIAlertController.init(title: "", message:message , preferredStyle: UIAlertControllerStyle.alert)
//                    let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
//                    alertController.addAction(okAction)
//                    self.present(alertController, animated: true, completion: nil)
//                    
//                }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
