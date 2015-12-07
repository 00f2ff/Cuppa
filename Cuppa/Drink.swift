//
//  Drink.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/2/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit
import Foundation

class Drink: NSObject {
  var name: String!
  var category: String!
  var image: String!
  var favorite: Bool!
  var ingredients: [Ingredient]!
  var details: String!
  
  override init () {
    super.init()
  }
  
  init(name: String, category: String, image: String, favorite: Bool, ingredients: [Ingredient], details: String) {
    super.init()
    self.name = name
    self.category = category
    self.image = image
    self.favorite = favorite
    self.ingredients = ingredients
    self.details = details
  }
}
