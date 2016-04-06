//
//  BaseTableViewController.swift
//  Serch
//
//  Created by Ravi Ranjan on 19/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    // MARK: Types
    
    static let nibName = "TableViewCell"
    static let tableViewCellIdentifier = "cellID"
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        
        // Required if our subclasses are to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)`.
        tableView.rowHeight = 110
        tableView.registerNib(nib, forCellReuseIdentifier: BaseTableViewController.tableViewCellIdentifier)
    }
    
    // MARK: Configuration
    
    func configureCell(cell: TableViewCell, forProduct product: Mechanic) {
        
        cell.name.text = product.name
        cell.phoneNumber.text = String(product.phone)
        cell.rating.text = String(product.rating)
        let locationText = product.local + " " + product.city + " " + product.country
        cell.location.text = locationText
    }
}