//
//  MMSparePartsViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/04/16.
//  Copyright © 2016 Ravi Ranjan. All rights reserved.
//

import UIKit
private let reuseIdentifier = "cell"
class MMSparePartsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let sparePartsName = ["Spareparts1","Spareparts1","Spareparts1","Spareparts1","Spareparts1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Spare Parts"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = BACKGROUND_COLOR
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sparePartsName.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MMSparepartsCollectionViewCell
        cell.sparePartsName.text = sparePartsName[indexPath.row]
        return cell
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
