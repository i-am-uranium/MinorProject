//
//  MMOfflineTableViewCell.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 13/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMOfflineTableViewCell: UITableViewCell {

    
    @IBOutlet var name: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
