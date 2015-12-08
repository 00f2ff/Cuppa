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
    var mutableIngredients : [Ingredient] = []
    for ingredient in ingredients {
      volume += ingredient.amount
      mutableIngredients.append(ingredient)
    }
    // sort ingredients
//    things.sort({ return $0.number < $1.number })
    mutableIngredients.sort({ return $0.amount < $1.amount })
    var ingredientVolumeSum = 0
    var volumeRatio : CGFloat = 0.0
    for i in 0...mutableIngredients.count-1 {
      var arcLayer = ArcLayer(volumeRatio: volumeRatio)
      arcLayer.fillColor = mutableIngredients[i].color().CGColor
      arcLayer.height = height// * CGFloat(ingredients[i].amount) / CGFloat(volume)
      arcLayer.width = width
//      arcLayer.volumeRatio = volumeRatio
      layer.addSublayer(arcLayer)
      arcLayer.animate() // could take an additional argument that would determine when it stops
      // height of next gets determined by previous'
      ingredientVolumeSum += mutableIngredients[i].amount
      volumeRatio = CGFloat(ingredientVolumeSum) / CGFloat(volume)
//      break
    }
    
  }
  
  
}
