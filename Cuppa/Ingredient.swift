//
//  Ingredient.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/2/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework

class Ingredient: NSObject {
  var name: String!
  var amount: Int!
  
  override init () {
    super.init()
  }
  
  init(name: String, amount: Int) {
    super.init()
    self.name = name
    self.amount = amount
  }
  
  func color() -> UIColor {
    var c : UIColor
    switch self.name {
    case "Coffee":
      c = FlatBrownDark()
    case "Foam":
      c = FlatWhiteDark()
    case "Milk":
      c = FlatWhite()
    case "Espresso":
      c = FlatBrown()
    case "Water":
      c = FlatPowderBlue()
    case "Coffee Liqueur":
      c = FlatSand()
    case "Ice":
      c = UIColor.whiteColor()
    case "Brown Sugar":
      c = FlatSandDark()
    case "Chocolate":
      c = FlatMaroonDark()
    case "Whipped Cream":
      c = FlatGray()
    case "Lemon":
      c = FlatYellow()
    case "Cinnamon":
      c = FlatOrange()
    case "Chai Tea":
      c = FlatGreenDark()
    case "Vanilla Ice Cream":
      c = FlatTeal()
    case "Triple Sec":
      c = FlatTealDark()
    case "Condensed Milk":
      c = FlatGrayDark()
    case "Cocoa Powder":
      c = FlatForestGreen()
    case "Cream":
      c = FlatPink()
    case "Sugar":
      c = FlatPurpleDark()
    case "Rum":
      c = FlatWatermelonDark()
    case "Whiskey":
      c = FlatRedDark()
    case "Lime":
      c = FlatLime()
    case "Honey":
      c = FlatYellowDark()
    case "Nutella":
      c = FlatSkyBlue()
    default:
      c = UIColor.whiteColor()
    }
    return c
  }
}