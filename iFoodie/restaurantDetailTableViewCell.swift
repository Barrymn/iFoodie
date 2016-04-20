//
//  restaurantDetailTableViewCell.swift
//  iFoodie
//
//  Created by Barry on 2016-03-21.
//  Copyright © 2016 Ning Ma. All rights reserved.
//

import UIKit

class restaurantDetailTableViewCell: UITableViewCell {
  
  @IBOutlet var fieldLabel:UILabel!
  @IBOutlet var valueLabel:UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
