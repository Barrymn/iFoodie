//
//  restaurantDetailViewController.swift
//  iFoodie
//
//  Created by Barry on 2016-03-17.
//  Copyright © 2016 Ning Ma. All rights reserved.
//

import UIKit

class restaurantDetailViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
  
  @IBOutlet var restaurantImageView:UIImageView!
  @IBOutlet var tableView:UITableView!
  @IBOutlet var ratingButton: UIButton!
  
  var restaurant:Restaurant!
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as!restaurantDetailTableViewCell
    
    cell.backgroundColor = UIColor.clearColor()

    // Configure the cell...
    switch indexPath.row {
      case 0:
        cell.fieldLabel.text = "Name"
        cell.valueLabel.text = restaurant.name
      case 1:
        cell.fieldLabel.text = "Type"
        cell.valueLabel.text = restaurant.type
      case 2:
        cell.fieldLabel.text = "Location"
        cell.valueLabel.text = restaurant.location
      case 3:
        cell.fieldLabel.text = "Phone #"
        cell.valueLabel.text = restaurant.phoneNumber
      case 4:
        cell.fieldLabel.text = "Been here"
        if let isVisited = restaurant.isVisited?.boolValue {
            cell.valueLabel.text = isVisited ? "Yes, I've been here before" : "No"
        }
      default:
        cell.fieldLabel.text = ""
        cell.valueLabel.text = ""
    }
    return cell
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    restaurantImageView.image = UIImage(data: restaurant.image!)
    
    tableView.backgroundColor = UIColor(red: 242.0/255.0, green: 213.0/255.0, blue: 187.0/255.0, alpha: 0.2)
    
    navigationController?.hidesBarsOnSwipe = false
    
    // Remove the separators of the empty rows
    tableView.tableFooterView = UIView(frame: CGRectZero)
    
    // Change the color of the separator
    tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    
    title = restaurant.name
    
    tableView.estimatedRowHeight = 36.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    ratingButton.layer.cornerRadius = 20
    
    if let rating = restaurant.rating where rating != "" {
        ratingButton.setImage(UIImage(named: restaurant.rating!), forState:
        UIControlState.Normal)
    }

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        if let reviewViewController = segue.sourceViewController as? restaurantReviewViewController {
            if let rating = reviewViewController.rating {
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating), forState: UIControlState.Normal)
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destinationViewController as! restaurantMapViewController
            destinationController.restaurant = restaurant
        }
    }
    
}
