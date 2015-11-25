//
//  MMTestTableViewCell.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 11/22/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMTestTableViewCell: UITableViewCell {
    
    // MARK : Properties
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
