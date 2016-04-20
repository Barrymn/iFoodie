//
//  addRestaurantTableViewController.swift
//  iFoodie
//
//  Created by Barry on 2016-03-22.
//  Copyright © 2016 Ning Ma. All rights reserved.
//

import UIKit
import CoreData

class addRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var restaurant:Restaurant!

    @IBOutlet var imageView:UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var isVisited: Bool! = true
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.lightGrayColor()
        }
        else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.lightGrayColor()
            noButton.backgroundColor = UIColor.redColor()
        }
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if(nameTextField.text == "" || typeTextField == "" || locationTextField.text == "") {
            let alertController = UIAlertController(title: "Oops",
                message: "We can't proceed because one of the fields is blank. Please note that all fields are required.",
                preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant",inManagedObjectContext: managedObjectContext) as! Restaurant
                restaurant.name = nameTextField.text!
                restaurant.type = typeTextField.text!
                restaurant.location = locationTextField.text!
                restaurant.phoneNumber = phoneNumberTextField.text!
                if let restaurantImage = imageView.image {
                    restaurant.image = UIImagePNGRepresentation(restaurantImage)
                }
                restaurant.isVisited = isVisited
                
                do{
                    try managedObjectContext.save()
                } catch {
                    print(error)
                    return
                }
            }
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self

                self.presentViewController(imagePicker, animated: true, completion:nil)
            }
        
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        bottomConstraint.active = true
                    
        dismissViewControllerAnimated(true, completion: nil)
    }
    


}
