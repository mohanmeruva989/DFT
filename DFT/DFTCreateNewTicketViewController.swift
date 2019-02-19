//
//  DFTCreateNewTicketViewController.swift
//  DFT
//
//  Created by Mohan on 13/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData
import Alamofire
import NohanaImagePicker
import Photos


class DFTCreateNewTicketViewController: UIViewController {
    var viewModel : CreateTicketViewModel?
    var dataModel : DFTHeaderType = DFTHeaderType(withDefaults: true)
    let modalLoadingIndicatorView = FUIModalLoadingIndicatorView()
    var convertedImages = [UIImage]()
    var imagePickerController = UIImagePickerController()
    var isGalleryOpenedOnce : Bool = false
    var pickedCameraImage = UIImage()
    var selectedImages = [PHAsset]()
    var attachments = [Attachment]()
    var wells = [Well]()
    var wellpads = [Wellpad]()
    var fields = [Field]()
    var facilities = [Facility]()
    @IBOutlet var galleryView: UICollectionView!
    
    @IBAction func addAttachments(_ sender: Any) {
        if convertedImages.count < 3{
        self.attachmentOptions()
        }
        else{
            let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true) })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
    @IBOutlet var attachmentView: UIView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBAction func segmentToggled(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            self.attachmentView.isHidden = false
        }else{
            self.attachmentView.isHidden = true
        }
    }
    
    @IBAction func onSubmitPress(_ sender: Any) {
        modalLoadingIndicatorView.show(inView: self.view)
        self.createDFTPayload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = CreateTicketViewModel(DFTType: .GeneralDFT)
        self.tableView.tableFooterView = UIView()
        self.attachmentView.isHidden = true
        self.galleryView.delegate = self
        self.galleryView.dataSource = self
        self.getLocationInfo()
        // Do any additional setup after loading the view.
    }
    func getLocationInfo() {
        wells.append(Well(name: "Briggs 10H"))
        wells.append(Well(name: "Briggs 11H"))
        wells.append(Well(name: "Briggs 20H"))
        
        wellpads.append(Wellpad(name: "Briggs 10H-11H", wells: nil))
        wellpads.append(Wellpad(name: "Briggs 13H-14H", wells: nil))
        wellpads.append(Wellpad(name: "Briggs 20H-25H", wells: nil))
        
        facilities.append(Facility(name: "Tom", wellpads: nil))
        facilities.append(Facility(name: "Fernandez", wellpads: nil))
        facilities.append(Facility(name: "Lenhart", wellpads: nil))

        fields.append(Field(name: "Karnes", facilites: nil))
        fields.append(Field(name: "North Tilden", facilites: nil))
        fields.append(Field(name: "South Tilden", facilites: nil))
    }
    
    func createDFTPayload() {
        
        
        self.postDFTayload(payload : self.getJsonBody())

    }
    func postDFTayload(payload : JSON)  {
        do{
            var data : Data?
            let urlSession = (UIApplication.shared.delegate as! AppDelegate).sapURLSession
            let url = try! "https://mobile-hkea136m18.hana.ondemand.com/com.incture.basexsodata/createFieldTicket.xsjs".asURL()
            var urlRequest = try! URLRequest(url: url, method: .post)
            do {
                data = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
                print(data)
            } catch let jsonError as NSError {
                print(jsonError.userInfo)
            }
            
            urlRequest.httpBody = data!
            let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    self.modalLoadingIndicatorView.dismiss()
                    self.navigationController?.popViewController(animated: true)
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
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
        catch{
            
        }
    }
    
    private func getJsonBody() -> JSON {
        let header : JSON = [
            "dftNumber": "",
            "poNumber": 0,
            "vendorAdminId": "",
            "vendorId": "300879",
            "vendorName": "Z-Chemicals Pvt Ltd",
            "vendorAddress": "PO 452,Texas",
            "aribaSesNo": "",
            "serviceProviderMail": User.shared.emailId ?? "",
            "serviceProviderId": User.shared.id ?? "",
            "serviceProviderName": User.shared.fullName ?? "",
            "ReviewerId": self.dataModel.reviewerID ?? "", //TBD
            "ReviewerName": "123",//TBD
            "ReviewerEmail": "123",//TBD
            "sesApproverName": "",
            "sesApproverEmail": "",
            "department": self.dataModel.department ?? "",//TBD
            "location": self.dataModel.location ?? "",//TBD
            "accountingCategory": "",
            "costCenter": "",
            "sesNumber": "",
            "workOrderNo": "",
            "signatureVersion": 0,
            "wbsElement": 0,
            "deviceType": "iOS",//TBD
            "deviceId": "123",//TBD
            "status": "Created",//TBD
            "createdBy": User.shared.fullName ?? "",//TBD
            "updatedBy": "",
            "vendorRefNumber": self.dataModel.vendorRefNumber ?? "",//TBD
            "createdOn":"2018-10-10T17:09:22.002Z",//TBD
            "reviewedBy": "",
            "completedBy": "",
            "updatedOn":"2018-10-10T17:09:22.002Z",//TBD
            "reviewedOn":"2018-10-10T17:09:22.002Z",
            "completedOn":"2018-10-10T17:09:22.002Z",//TBD
            "well": "123",//TBD
            "field": "123",//TBD
            "facility": "123",//TBD
            "wellPad": "123",//TBD
            "ownerId": self.dataModel.reviewerID ?? "",//TBD
            "startDate":"2018-10-10",//TBD
            "startTime":"10:10:10",//TBD
            "endDate":"2019-10-10",//TBD
            "endTime":"10:10:10"//TBD
        ]
        
        let body : [String : Any] =
                [
                "header": header,
                "comments": [[
                "commentId": "",
                "dftNumber": "",
                "commentedByName": "surya",
                "commentedOn": "2018-10-10T17:09:22.002Z",
                "comment": "test"
                ]],
                "attachments": [[
                "attachmentId": "",
                "dftNumber": "",
                "attachmentName": "",
                "dftAttachmentType": "",
                "createdByName": "",
                "createdOn": "2018-10-10T17:09:22.002Z",
                "updatedByName": "",
                "updatedOn": "2018-10-10T17:09:22.002Z",
                "attachmentUrl": "www.google.com"
                ]],
                "changeLog": [[
                "activityId": "",
                "dftNumber": "",
                "wfInstanceId": "",
                "status": "",
                "createdOn": "2018-10-10T17:09:22.002Z",
                "createdByName": ""
                ]]
                        ]

        return body
    }

}
extension DFTCreateNewTicketViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.tableViewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData : CellModel = (self.viewModel?.tableViewModel?[indexPath.row])!
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(dismissPicker))
        let pickerView = UIPickerView()
        switch cellData.dequeCell {
        case "DFTCreateTableViewCell":
            let  cell = tableView.dequeueReusableCell(withIdentifier: "DFTCreateTableViewCell")! as! DFTCreateTableViewCell
            cell.setData(cellData)
            cell.cellTextField.inputAccessoryView = toolBar
            cell.delegate = self
            cell.dataModel = self.dataModel
          return cell
        case "DFTDateTimeTableViewCell" :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DFTDateTimeTableViewCell")! as! DFTDateTimeTableViewCell
            cell.setData(cellData)
            cell.textField2.inputAccessoryView = toolBar
            cell.textField1.inputAccessoryView = toolBar
//            cell.textField1.delegate = self
//            cell.textField2.delegate = self
           return cell
        default:
            print("Invalid deque cell")
            return UITableViewCell()
        }

    }
    @objc func dismissPicker(){
        view.endEditing(true)
        
    }
    
}
extension DFTCreateNewTicketViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellData : CellModel = (self.viewModel?.tableViewModel?[indexPath.row])!
        switch cellData.identifier {
        case "StartDetails":
            return 100
        case "EndDetails":
            return 100
        default:
            return 70
        }
    }
}
extension DFTCreateNewTicketViewController : UIPickerViewDelegate{
    override func didChangeValue(forKey key: String) {
        self.viewModel?.tableViewModel
    }
}
extension UIToolbar {
    
    func ToolbarPicker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
extension DFTCreateNewTicketViewController : DFTTableViewCellDelegate{
    func updateModel(cellModel: CellModel) {
//        switch cellModel.identifier {
//        case "VendorRefNo":
//            self.dataModel.vendorRefNumber = cellModel.inputValue as? String
//        case "Department":
//            self.dataModel.department = cellModel.inputValue as? String
//        case "Location":
//            self.dataModel.location = cellModel.inputValue as? String
//        case "Reviewer":
//            self.dataModel.reviewerID = cellModel.inputValue as? String
//
////        case "StartDetails":
////            self.dataModel.setOptionalValue(for:, to: <#T##DataValue?#>) = cellModel.inputValue as? String
////
////        case "EndDetails":
////            self.dataModel.vendorRefNumber = cellModel.inputValue as? String
//
//
//        default:
//            print("Error")
//        }
        self.tableView.reloadData()
}
    func openLocation() {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "DFTLocationViewController") as! DFTLocationViewController
        locationVC.currentLocationType = "Fields"
        locationVC.dataModel = self.dataModel
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
}
// Mark : - Attachments

extension DFTCreateNewTicketViewController {
    func attachmentOptions(){
        
        let attribute : [NSAttributedString.Key : Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16),
                                                         NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        
        let attributedText = NSAttributedString(string: "Attachment Options", attributes: attribute)
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        alertController.setValue(attributedText, forKey: "attributedTitle")
        
        let camera = UIAlertAction(title: "Open Camera", style: .default, handler: { (action) -> Void in
            
            self.openCamera()
        })
        
        
        let gallery_images = UIAlertAction(title: "Open gallery", style: .default, handler: { (action) -> Void in
            
            self.openGallery()
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: { (action) -> Void in
            
            print("Ok button tapped")
        })
        alertController.addAction(camera)
        alertController.addAction(gallery_images)
        alertController.addAction(cancel)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if convertedImages.count < 3{
            self.imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            self.imagePickerController.allowsEditing = true
            self.present(self.imagePickerController, animated : true, completion : nil)
        }
        else{
            let alertController = UIAlertController.init(title: "", message:"Maximum 3 attachments allowed." , preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func openGallery()
    {
        if isGalleryOpenedOnce == false{
            checkIfAuthorizedToAccessPhotos { isAuthorized in
                DispatchQueue.main.async(execute: {
                    if isAuthorized {
                        self.isGalleryOpenedOnce = true
                        self.openOtherGallery()
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Denied access to photos.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
            
        }
        else{
            self.openOtherGallery()
        }
    }
    func checkIfAuthorizedToAccessPhotos(_ handler: @escaping (_ isAuthorized: Bool) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        handler(true)
                    default:
                        handler(false)
                    }
                }
            }
        case .restricted:
            handler(false)
        case .denied:
            handler(false)
        case .authorized:
            handler(true)
        }
    }
    
    func openOtherGallery(){
        
        
        let imagePicker = NohanaImagePickerController()
        // Set the maximum number of selectable images
        let maxcount = 3
        let selectedCount = self.convertedImages.count
        imagePicker.maximumNumberOfSelection = maxcount - selectedCount
        
        if maxcount - selectedCount == 0{
            let alertController = UIAlertController.init(title: "", message:"Maximum 3 attachments allowed." , preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            // Set the cell size
            imagePicker.numberOfColumnsInPortrait = 2
            imagePicker.numberOfColumnsInLandscape = 3
            
            // Show Moment
            imagePicker.shouldShowMoment = true
            imagePicker.shouldShowEmptyAlbum = false
            
            // Hide toolbar
            // imagePicker.shouldShowEmptyAlbum = true
            // Disable to pick asset
            imagePicker.canPickAsset = { (asset:Asset) -> Bool in
                return true
            }
            
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }


}
extension DFTCreateNewTicketViewController : NohanaImagePickerControllerDelegate{
    func nohanaImagePickerDidCancel(_ picker: NohanaImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func nohanaImagePicker(_ picker: NohanaImagePickerController, didFinishPickingPhotoKitAssets pickedAssts: [PHAsset]) {
        self.selectedImages.removeAll()
        self.selectedImages.append(contentsOf: pickedAssts)
        convertToUIImage()
        //        for each in pickedAssts{
        //
        //        }
        picker.dismiss(animated: true, completion: nil)
    }
    func convertToUIImage(){
        //convertedImages.removeAll()
        for images in selectedImages{
            
            let image = getAssetThumbnail(asset: images)
            convertedImages.append(image)
        }
        self.galleryView.reloadData()
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        
        let options = PHImageRequestOptions()
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        var thumbnail = UIImage()
        
        options.progressHandler = {  (progress, error, stop, info) in
            print("progress: \(progress)")
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: {
            (image, info) in
            thumbnail = image!
        })
        return thumbnail
    
    }
    func getDeletedIndex(index : Int){
        
        convertedImages.remove(at: index)
        galleryView.reloadData()
    }

    
}
extension DFTCreateNewTicketViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        pickedCameraImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
            self.dismiss(animated: true) { () -> Void in
            self.convertedImages.append(self.pickedCameraImage)
            self.galleryView.reloadData()
    }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
extension DFTCreateNewTicketViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.convertedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DFTGalleryCollectionViewCell = galleryView.dequeueReusableCell(withReuseIdentifier: "DFTGalleryCollectionViewCell", for: indexPath) as! DFTGalleryCollectionViewCell
        cell.setThumbnail(thumbImage : convertedImages[indexPath.row], sender: self,index : indexPath.row)
        return cell
    }
}
extension DFTCreateNewTicketViewController : UICollectionViewDelegate{
    
}
extension DFTCreateNewTicketViewController{
    
    func callDocumentService(documentsArray : [Attachment]){
        var payload = [String : Any]()
        var documentInfoList = [[String: Any]]()
        self.modalLoadingIndicatorView.show(inView: self.view)
        
        
        for document in documentsArray{
            let documentInfo : [String : Any] =
                [
                    "folderName": "DFT",
                    "fileType" : document.attachmentType ,
                    "fileName" : document.attachmentName ,
                    "fileContent" : document.attachmentContent,
                    "country": "US",
                    "region": "HOUSTON",
                    "project": "DFT",
                    "module": "DFT",
                    "createdBy": document.createdBy,
                    "createdOn": document.createdOn,
                    "appId": "DFT",
                    
                    ]
            
            documentInfoList.append(documentInfo)
        }
        
        
        payload ["documentDetailDtoList"] =  documentInfoList
//
//        Alamofire.request("\(BaseUrl.apiURL)/DftDocumentService/upload", method: .put, parameters: payload, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            if response.result.isSuccess, let jsonArray = response.result.value as? [[String : Any]] {
//                self.modalLoadingIndicatorView.dismiss()
//                var i = 0
//                for each in jsonArray{
//                    if let documentDetailDto = each["documentDetailDto"] as? [String : Any]{
//                        //                            for each in self.attachments{
//                        //                                if each.attachmentName == documentDetailDto["fileName"] as! String{
//                        //                                    each.documentId = documentDetailDto["documentId"] as? String
//                        //                                    each.attachmentUrl = documentDetailDto["documentUrl"] as? String
//                        //                                }
//                        //                            }
//                        self.attachments[i].attachmentUrl = "https://dmsappd7e367960.us2.hana.ondemand.com/AppDownload/murphy/documents/download/" + (documentDetailDto["documentId"] as! String)
//                        print(self.attachments[i].attachmentUrl)
//                        self.attachments[i].documentId = documentDetailDto["documentId"] as? String
//                        i = i+1
//                    }
//                }
//                self.createDFTPayload()
//            }
//            else if response.result.isFailure{
//                print("Document Service Failed")
//                print(response.result)
//            }
        }
    }
//    func getAttachments()
//    {
//
//        // self.convertToUIImage()
//        self.attachments.removeAll()
//
//        if convertedImages.count == 0{
//
//            let alertController = UIAlertController.init(title: "", message:"Please add minimum of 1 Attachment." , preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else{
//            var count = 0
//            for image in convertedImages{
//
//                let attachment = Attachment()
//                let imageData:NSData = UIImageJPEGRepresentation(image, 0.2)! as NSData
//                let imageSize = imageData.length
//                let value = ByteCountFormatter.string(fromByteCount: Int64(imageSize), countStyle: .file)
//                print(value)
//                let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
//                attachment.attachmentContent = strBase64
//                attachment.attachmentLength = strBase64.lengthOfBytes(using: .utf8)
//                attachment.attachmentName = UserDefaults.standard.string(forKey: "id")! + "_" + String(describing: count) + "_" + String(describing: Date()) + ".jpeg"
//                attachment.attachmentType = "image/jpeg"
//                attachment.ServiceProviderId = UserDefaults.standard.string(forKey: "id")!
//                attachments.append(attachment)
//                count += 1
//            }
//                callDocumentService(documentsArray : attachments)
//
//
//        }
//    }
//}
