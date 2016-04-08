//
//  MMOnlineTableViewCell.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 17/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMOnlineTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var star: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
