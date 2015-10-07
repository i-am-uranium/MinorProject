//
//  MMTableViewCell.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMTableViewCell: UITableViewCell {
    
    
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var distanceFromyou: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
