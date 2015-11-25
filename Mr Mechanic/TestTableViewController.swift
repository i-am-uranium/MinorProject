//
//  TestTableViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 23/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    @IBOutlet weak var act_ind: UIActivityIndicatorView!
    
    var fetch = RestApiManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Testing Server"
        fetch.fetchData()

    }

    override func viewDidAppear(animated: Bool) {
        self.act_ind.startAnimating()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetch.arrayCount()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! MMTestTableViewCell
        if fetch.arrayCount() != 0{
        self.act_ind.stopAnimating()
        let (name,phone,_,_,rating,address,_,_,_) = fetch.returnFetchedData(indexPath)

        cell.nameLabel.text = name
        cell.addressLabel.text = address
        cell.phoneNumberLabel.text = String(phone)
        cell.ratingLabel.text = String(rating)
        cell.starImage.image = UIImage(named: "star-40")
        cell.phone.text = "Phone :"
            return cell
        }
        return cell
    }


   

}
