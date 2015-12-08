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
  @IBOutlet weak var cupHolderView: CupHolderView!
  //  @IBOutlet weak var cupView : UIView!
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
      
      cupHolderView.drawArc(cupHolderView.frame.height, width: cupHolderView.frame.width, ingredients: thisDrink.ingredients!)
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
      } else {
        // there may not also be an image
        cell.amountLabel.text = ""
      }
      cell.circleView.color = ingredient.color()
    }
    return cell
  } // tableView
  
  
  
  
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  } // tableView
  
  
  // SEGUES
  
  
  
  // FUNCTIONS
  
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