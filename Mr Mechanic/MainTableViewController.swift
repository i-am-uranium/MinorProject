//
//  MainTableViewController.swift
//  Serch
//
//  Created by Ravi Ranjan on 19/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

/*
Abstract:
The application's primary table view controller showing a list of mechanic.
*/

import UIKit

class MainTableViewController: BaseTableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    // MARK: Types
    
    /// State restoration values.
    enum RestorationKeys : String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    // MARK: Properties
    
    /// Data model for the table view.
    var mechanic = [Mechanic]()
    let tintColor = UIColor(netHex: 0xfa3562)
    
    /*
    The following 2 properties are set in viewDidLoad(),
    They an implicitly unwrapped optional because they are used in many other places throughout this view controller
    */
    
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    
    /// Secondary search results table view.
    var resultsTableController: ResultsTableController!
    
    /// Restoration state for UISearchController
    var restoredState = SearchControllerRestorableState()
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        resultsTableController = ResultsTableController()

        // We want to be the delegate for our filtered table so didSelectRowAtIndexPath(_:) is called for both tables.
        resultsTableController.tableView.delegate = self
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = tintColor
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others
        
        /*
        Search is now just presenting a view controller. As such, normal view controller
        presentation semantics apply. Namely that presentation will walk up the view controller
        hierarchy until it finds the root view controller or one that defines a presentation context.
        */
        definesPresentationContext = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.active = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchControllerDelegate
    
    func presentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // Update the filtered array based on the search text.
        let searchResults = mechanic
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        let strippedString = searchController.searchBar.text!.stringByTrimmingCharactersInSet(whitespaceCharacterSet)
        let searchItems = strippedString.componentsSeparatedByString(" ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            var searchItemsPredicate = [NSPredicate]()
            // address field matching.
            let addressExpression = NSExpression(forKeyPath: "address")
            let searchStringExpression = NSExpression(forConstantValue: searchString)
            
            let titleSearchComparisonPredicate = NSComparisonPredicate(leftExpression: addressExpression, rightExpression: searchStringExpression, modifier: .DirectPredicateModifier, type: .ContainsPredicateOperatorType, options: .CaseInsensitivePredicateOption)
            
            searchItemsPredicate.append(titleSearchComparisonPredicate)
            
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .NoStyle
            numberFormatter.formatterBehavior = .BehaviorDefault
            
            let targetNumber = numberFormatter.numberFromString(searchString)
            
            // `searchString` may fail to convert to a number.
            if targetNumber != nil {
                // Use `targetNumberExpression` in both the following predicates.
                let targetNumberExpression = NSExpression(forConstantValue: targetNumber!)
                
                // `rating` field matching.
                let cityExpression = NSExpression(forKeyPath: "rating")
                let ratingPredicate = NSComparisonPredicate(leftExpression: cityExpression, rightExpression: targetNumberExpression, modifier: .DirectPredicateModifier, type: .EqualToPredicateOperatorType, options: .CaseInsensitivePredicateOption)
            
                searchItemsPredicate.append(ratingPredicate)
                
                // `phone number` field matching.
                let lhs = NSExpression(forKeyPath: "phone")
                
                let finalPredicate = NSComparisonPredicate(leftExpression: lhs, rightExpression: targetNumberExpression, modifier: .DirectPredicateModifier, type: .EqualToPredicateOperatorType, options: .CaseInsensitivePredicateOption)
                
                searchItemsPredicate.append(finalPredicate)
            }
            
            // Add this OR predicate to our master AND predicate.
            let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
            return orMatchPredicate
        }
        
        // Match up the fields of the Mechanic object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluateWithObject($0) }
        
        // Hand over the filtered results to our search results table.
        let resultsController = searchController.searchResultsController as! ResultsTableController
        resultsController.filteredMechanic = filteredResults
        resultsController.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mechanic.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseTableViewController.tableViewCellIdentifier, forIndexPath: indexPath) as! TableViewCell
        
        let product = mechanic[indexPath.row]
        configureCell(cell, forProduct: product)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedProduct: Mechanic
        
        // Check to see which table view cell was selected.
        if tableView === self.tableView {
            selectedProduct = mechanic[indexPath.row]
        }
        else {
            selectedProduct = resultsTableController.filteredMechanic[indexPath.row]
        }
        
        // Set up the detail view controller to show.
        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedProduct)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: UIStateRestoration
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        super.encodeRestorableStateWithCoder(coder)
        
        // Encode the view state so it can be restored later.
        
        // Encode the title.
        coder.encodeObject(navigationItem.title!, forKey:RestorationKeys.viewControllerTitle.rawValue)
        
        // Encode the search controller's active state.
        coder.encodeBool(searchController.active, forKey:RestorationKeys.searchControllerIsActive.rawValue)
        
        // Encode the first responser status.
        coder.encodeBool(searchController.searchBar.isFirstResponder(), forKey:RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // Encode the search bar text.
        coder.encodeObject(searchController.searchBar.text, forKey:RestorationKeys.searchBarText.rawValue)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        super.decodeRestorableStateWithCoder(coder)
        
        // Restore the title.
        guard let decodedTitle = coder.decodeObjectForKey(RestorationKeys.viewControllerTitle.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
            
        }
        title = decodedTitle
        
        // Restore the active state:
        // We can't make the searchController active here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasActive = coder.decodeBoolForKey(RestorationKeys.searchControllerIsActive.rawValue)
        
        // Restore the first responder status:
        // Like above, we can't make the searchController first responder here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasFirstResponder = coder.decodeBoolForKey(RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // Restore the text in the search field.
        searchController.searchBar.text = coder.decodeObjectForKey(RestorationKeys.searchBarText.rawValue) as? String
    }
}
