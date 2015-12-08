//
//  DrinkCell.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/2/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class DrinkCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var drinkImageView: UIImageView!
  
//  @IBOutlet weak var nameLabel: UILabel!
  // implementing images later
//  @IBOutlet weak var drinkImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.backgroundColor = UIColor.clearColor()
  }
  
  //  override func setSelected(selected: Bool, animated: Bool) {
  //    super.setSelected(selected, animated: animated)
  //
  //    // Configure the view for the selected state
  //  }
  
}