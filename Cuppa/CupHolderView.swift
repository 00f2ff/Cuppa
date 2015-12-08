//
//  CupHolderView.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit

class CupHolderView : UIView {
  
//  let arcLayer = ArcLayer()
  
  var parentFrame : CGRect = CGRectZero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clearColor()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func drawArc(height: CGFloat, width: CGFloat, ingredients: [Ingredient]) {
    // find total volume of drink
    var volume = 0
    for ingredient in ingredients {
      volume += ingredient.amount
    }
    for i in 0...ingredients.count-1 {
      var arcLayer = ArcLayer()
      println(ingredients[i].name)
      println(ingredients[i].amount)
      arcLayer.fillColor = ingredients[i].color().CGColor
      arcLayer.height = height * CGFloat(ingredients[i].amount) / CGFloat(volume)
      arcLayer.width = width
      layer.addSublayer(arcLayer)
      arcLayer.animate() // could take an additional argument that would determine when it stops
      // sleep is bad but I'm curious
//      break
    }
    
  }
  
  
}
