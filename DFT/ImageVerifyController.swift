//
//  ImageVerifyController.swift
//  MurphyDFT-Final
//
//  Created by Soumya Singh on 15/02/18.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit
import Alamofire

class ImageVerifyController: UIViewController {

    @IBOutlet var signatureImage: UIImageView!
    @IBOutlet var disclaimerView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNavBar()
        getSignature()
//        let htmlText = "<ul style = 'color : #868686 ; font-size : 14;'><li><i>All Commercial Terms are to be in accordance to Murphy Oil MSA and originating Work Order.</i></li><li><i>Field/Wellsite Operations Stamp is a confirmation of services/materials received only.</i></li></ul>"
//        let attrStr = try! NSAttributedString(
//            data: htmlText.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
//            options: [ .documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil)
//        disclaimerView.attributedText = attrStr

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        let base64String = UserDefaults.standard.string(forKey: "digisign")!
//        let data: Data = Data(base64Encoded: base64String , options: .ignoreUnknownCharacters)!
//        // turn  Decoded String into Data
//        let dataImage = UIImage(data:data,scale:1.0)
//        self.signatureImage.image = dataImage
    }
    
    func createNavBar() {
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Verify Signature"
        let backItem = UIBarButtonItem.init(image: UIImage(named : "Back")?.withRenderingMode(.alwaysTemplate), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissScreen))
        let updateItem = UIBarButtonItem.init(title: "UPDATE", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.updateSignature))
        navigationItem.rightBarButtonItem = updateItem
        navigationItem.leftBarButtonItem = backItem
        
    }
    
    @objc func updateSignature(){
        
        let splitViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DigitalSignatureController") as! DigitalSignatureController
        let navCont = UINavigationController(rootViewController: splitViewController)
        self.present(navCont, animated: true)    }
    
    @objc func dismissScreen(){
            self.navigationController?.popViewController(animated: true)
        }
    
    ///Dft_SignatureSet?$filter=ApproverId eq '77'
//
    func getSignature() {
            if let url: String = User.shared.signatureUrl{
            self.signatureImage.af_setImage(withURL: URL(string: url)!)}
            else{
            let splitViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DigitalSignatureController") as! DigitalSignatureController
                let navCont = UINavigationController(rootViewController: splitViewController)
                self.present(navCont, animated: true)
        }
    }
}
