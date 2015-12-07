
//
//  IngredientCell.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/3/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit

class IngredientCell: UITableViewCell {
  
  @IBOutlet weak var ingredientLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var circleView: CircleView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  //  override func setSelected(selected: Bool, animated: Bool) {
  //    super.setSelected(selected, animated: animated)
  //
  //    // Configure the view for the selected state
  //  }
  
}