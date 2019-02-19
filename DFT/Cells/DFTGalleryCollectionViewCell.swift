//
//  DFTGalleryCollectionViewCell.swift
//  DFT
//
//  Created by Mohan on 19/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBAction func cancelPressed(_ sender: Any) {
            senderController?.getDeletedIndex(index: currentIndex!)
    }
    
    @IBOutlet var galleryImage: UIImageView!
    var senderController : DFTCreateNewTicketViewController?
        var currentIndex : Int?
        func setThumbnail( thumbImage : UIImage, sender : DFTCreateNewTicketViewController, index : Int ){
            galleryImage.image = thumbImage
            senderController = sender
            currentIndex = index
        }
    
}
