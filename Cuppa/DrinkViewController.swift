//
//  DrinkViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/3/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class DrinkViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // OUTLETS
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var cupHolderView: UIView!
  //  @IBOutlet weak var favoriteButton : UIButton!

  
  // ACTIONS
//  @IBAction func favoriteStatusHasChanged(sender: UIButton) {
//    if let thisDrink = drink {
//      // change favorite status
//      thisDrink.favorite = !thisDrink.favorite
//      // update UI
//      changeButtonTitle(thisDrink)
//      // save data
//    }
//  }
  
  
  // VARIABLES
  var drink: Drink?
  var thisDrink : Drink!
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // safely unwrap drink data
    if let thisDrink = drink {
      println(thisDrink.name)
      nameLabel.text = thisDrink.name
      detailsLabel.text = thisDrink.details
      tableView.delegate = self
      tableView.dataSource = self
      // remove extra lines at bottom
      tableView.tableFooterView = UIView()
      tableView.separatorColor = UIColor.clearColor()
      cupHolderView.backgroundColor = UIColor.clearColor()
      // mask view to be curved
      var maskPath = UIBezierPath(roundedRect: cupHolderView.bounds, byRoundingCorners: .BottomRight | .BottomLeft, cornerRadii: CGSize(width: 40.0, height: 40.0))
      let maskLayer = CAShapeLayer()
      maskLayer.path = maskPath.CGPath
      cupHolderView.layer.mask = maskLayer
      
      self.loadCupView(thisDrink.ingredients)
    }
  } // viewDidLoad
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  } // didReceiveMemoryWarning
  
  
  // DELEGATES
  // UITextFieldDelegate methods
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  } // numberOfSectionsInTableView
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let thisDrink = drink {
      return thisDrink.ingredients.count
    } else {
      return 0
    }
  } // tableView
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell") as! IngredientCell
    if let thisDrink = drink {
      let ingredient = thisDrink.ingredients[indexPath.row]
      // handle image later
      cell.ingredientLabel.text = ingredient.name
      if ingredient.amount > 0 {
        cell.amountLabel.text = "\(ingredient.amount) oz"
        cell.circleView.color = ingredient.color()
      } else {
        cell.amountLabel.text = ""
        // no circle
      }
      
    }
    return cell
  } // tableView
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  } // tableView
  
  func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
  }
  
  
  // SEGUES
  
  
  // FUNCTIONS
  func loadCupView(ingredients: [Ingredient]) {
    var x : CGFloat = 0
    var y : CGFloat = cupHolderView.frame.height
    var height : CGFloat = cupHolderView.frame.height
    var width : CGFloat = cupHolderView.frame.width + 20 // overshoots but that's fine
    var totalVolume : CGFloat = 0
    var mutableIngredients : [Ingredient] = []
    for ingredient in ingredients {
      totalVolume += CGFloat(ingredient.amount)
      mutableIngredients.append(ingredient)
    }
    // sort ingredients
    mutableIngredients.sort({ return $0.amount < $1.amount })
    for ingredient in mutableIngredients {
      var volumeRatio = CGFloat(ingredient.amount) / totalVolume
      // is this relative to the bottom-left corner of cupHolderView? I think so.
      var frame = CGRect(x: 0, y: y, width: width, height: height * volumeRatio) // origin is lower-left
      var rect = UIView(frame: frame)
      rect.backgroundColor = ingredient.color()
      cupHolderView.addSubview(rect)
      UIView.animateWithDuration(2, animations: {
        rect.frame = CGRect(x: 0, y: y - height, width: width, height: height * volumeRatio)
      })
      y += height * volumeRatio
    }
  } // loadCupView
  
  //  func changeButtonTitle(thisDrink: Drink) {
  //    if (thisDrink.favorite != false) {
  //      favoriteButton.setTitle("Unfavorite", forState: .Normal)
  //    } else {
  //      favoriteButton.setTitle("Favorite", forState: .Normal)
  //    }
  //  }
  
}