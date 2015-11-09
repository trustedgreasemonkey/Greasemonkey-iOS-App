//
//  ServiceCell.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell{

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
