//
//  DFTGalleryTableViewCell.swift
//  DFT
//
//  Created by Mohan on 22/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit

class DFTGalleryTableViewCell: UITableViewCell {
    var senderController : DFTCreateNewTicketViewController?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var galleryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
