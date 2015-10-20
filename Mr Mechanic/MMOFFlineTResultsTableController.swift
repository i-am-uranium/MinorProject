//
//  ResultsTableController.swift
//  Serch
//
//  Created by Ravi Ranjan on 19/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
/*
Abstract:
The table view controller responsible for displaying the filtered products as the user types in the search field.
*/
import UIKit

class ResultsTableController: BaseTableViewController {
    // MARK: Properties
    
    var filteredMechanic = [Mechanic]()
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMechanic.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseTableViewController.tableViewCellIdentifier) as! TableViewCell
        
        let product = filteredMechanic[indexPath.row]
        configureCell(cell, forProduct: product)
        
        return cell
    }
}
