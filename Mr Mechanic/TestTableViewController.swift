//
//  TestTableViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 23/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    var fectch = RestApiManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        fectch.fetchData()

    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fectch.arrayCount()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        let (name,phone,lat,long,rating,address,local,city,country) = fectch.returnFetchedData(indexPath)

        cell.textLabel?.text = city
        return cell
    }


   

}
