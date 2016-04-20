//
//  restaurantReviewViewController.swift
//  iFoodie
//
//  Created by Barry on 2016-03-21.
//  Copyright © 2016 Ning Ma. All rights reserved.
//

import UIKit

class restaurantReviewViewController: UIViewController {
    
    var rating:String?
    
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var ratingStackView:UIStackView!
    
    @IBAction func ratingSelected(sender: UIButton) {
        switch (sender.tag) {
            case 100: rating = "dislike"
            case 200: rating = "good"
            case 300: rating = "great"
            default: break
        }
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        ratingStackView.transform = CGAffineTransformConcat(scale, translate)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.3, options: [], animations: {
                self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

}
