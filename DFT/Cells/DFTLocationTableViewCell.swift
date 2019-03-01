//
//  DFTLocationTableViewCell.swift
//  DFT
//
//  Created by Mohan on 19/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import UIKit
protocol LocationCellDelgate {
    func didLocationTapped(cell : DFTLocationTableViewCell)
}
class DFTLocationTableViewCell: UITableViewCell {
    
    @IBOutlet var cellButton: UIButton!
    @IBAction func cellButtonTapped(_ sender: Any) {
        self.delegate?.didLocationTapped(cell: self)
    }
    
    var delegate : LocationCellDelgate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        self.cellButton.titleLabel?.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
