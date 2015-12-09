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
  //  @IBOutlet weak var cupView : UIView!
  //  @IBOutlet weak var favoriteButton : UIButton!
  
  
  @IBOutlet weak var cupBorderView: UIView!
  
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
//  var cupView = CupView(frame: CGRectZero)
  var drink: Drink?
  var thisDrink : Drink!
//  var cupHolderView = CupHolderView(frame: CGRectZero)
  
  
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
      
//      cupHolderView.layer.cornerRadius = 80
//      cupHolderView.layer.borderColor = UIColor.blackColor().CGColor
//      cupHolderView.layer.borderWidth = 5.0
      
      var maskPath = UIBezierPath(roundedRect: cupHolderView.bounds, byRoundingCorners: .BottomRight | .BottomLeft, cornerRadii: CGSize(width: 40.0, height: 40.0))
//      maskPath.addClip()
//      UIColor.blackColor().setStroke()
//      maskPath.lineWidth = 5.0
//      maskPath.stroke()
      let maskLayer = CAShapeLayer()
      maskLayer.path = maskPath.CGPath
//      cupHolderView.layer.borderColor = UIColor.blackColor().CGColor
//      cupHolderView.layer.borderWidth = 5.0
      var maskPath2 = UIBezierPath(roundedRect: cupBorderView.bounds, byRoundingCorners: .BottomRight | .BottomLeft, cornerRadii: CGSize(width: 45.0, height: 45.0))
      let maskLayer2 = CAShapeLayer()
      maskLayer2.path = maskPath2.CGPath
      cupHolderView.layer.mask = maskLayer
      cupBorderView.layer.mask = maskLayer2
//      cupHolderView.layer.addSublayer(maskLayer)
      
      
      self.loadCupView(thisDrink.ingredients)
      
      
      
//      cupHolderView.drawArc(cupHolderView.frame.height, width: cupHolderView.frame.width, ingredients: thisDrink.ingredients!)
    }
//    addCupView()
    
    
//    cupHolderView.drawArc(FlatCoffee().CGColor, height: cupHolderView.frame.height, width: cupHolderView.frame.width, beginTime: 1.0)
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
  
  
  // SEGUES
  
  
  
  // FUNCTIONS
  func loadCupView(ingredients: [Ingredient]) {
    var x : CGFloat = 0
//    var y : CGFloat = 0 // cupHolderView.frame.height
    var y : CGFloat = cupHolderView.frame.height
    var height : CGFloat = cupHolderView.frame.height
    var width : CGFloat = cupHolderView.frame.width + 20 // overshoots but that's fine
//    drawCup(height, width: width)
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
  
  func drawCup(height: CGFloat, width: CGFloat) {
    var rectangleLayer = RectangleLayer()
    cupHolderView.layer.addSublayer(rectangleLayer)
//    rectangleLayer.animateStrokeWithColor(UIColor.redColor())
    rectangleLayer.draw()
  }
  
  //  func changeButtonTitle(thisDrink: Drink) {
  //    if (thisDrink.favorite != false) {
  //      favoriteButton.setTitle("Unfavorite", forState: .Normal)
  //    } else {
  //      favoriteButton.setTitle("Favorite", forState: .Normal)
  //    }
  //  }
  
//  func addCupView() {
//    let boxSize: CGFloat = 100.0
//    cupView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
//      y: view.bounds.height / 2 - boxSize / 2,
//      width: boxSize,
//      height: boxSize)
//    view.addSubview(cupView)
//  } // addCupView
  
}