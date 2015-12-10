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
  @IBOutlet weak var favoriteButton: UIButton!
  //  @IBOutlet weak var favoriteButton : UIButton!

  
  // ACTIONS
  @IBAction func favoriteStatusHasChanged(sender: UIButton) {
    if let thisDrink = drink {
      // change favorite status
//      thisDrink.favorite = !thisDrink.favorite
      // update UI
      favorite(thisDrink)
      // save data
    }
  }
  
  
  // VARIABLES
  var drink: Drink?
  var thisDrink : Drink!
  let dataManager = DataManager()
  var favorites = [String]()
  var favoriteButtonImageName = "Hearts-32.png"
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // safely unwrap drink data
    if let thisDrink = drink {
      println(thisDrink.name)
      nameLabel.text = thisDrink.name
      detailsLabel.text = thisDrink.details
      
      favorites = dataManager.favorites
      if contains(favorites, thisDrink.name) {
        setButtonImage("Hearts-Filled-32.png")
      } else {
        setButtonImage("Hearts-32.png")
      }
      
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
  
  override func viewWillAppear(animated: Bool) {
    self.dataManager.loadFavorites()
    self.favorites = self.dataManager.favorites
    // below is repeated code
    if let thisDrink = drink {
      if contains(favorites, thisDrink.name) {
        setButtonImage("Hearts-Filled-32.png")
      } else {
        setButtonImage("Hearts-32.png")
      }
      
    }
    
    // trying to get tableView height to equal sum of cells (doesn't work)
//    var frame = self.tableView.frame;
//    frame.size.height = self.tableView.contentSize.height;
//    self.tableView.frame = frame;
    super.viewWillAppear(false)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  } // didReceiveMemoryWarning
  
  // only permit portrait
  override func shouldAutorotate() -> Bool {
    return false
  }
  
  override func supportedInterfaceOrientations() -> Int {
    return UIInterfaceOrientation.Portrait.rawValue
  }
  
  
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
    var y : CGFloat = cupHolderView.frame.height + 3
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
  
  func favorite(thisDrink: Drink) { // since I'm not updating the actual JSON, this uses a different check
    println(favoriteButtonImageName)
    if favoriteButtonImageName == "Hearts-32.png" { // meaning user just clicked 'favorite'
      // check it doesn't already exist (just in case)
      if (find(favorites, thisDrink.name) == nil) {
        favorites.append(thisDrink.name)
        setButtonImage("Hearts-Filled-32.png")
      }
      
    } else {
      favorites.removeAtIndex(find(favorites, thisDrink.name)!)
      setButtonImage("Hearts-32.png")
    }
    dataManager.favorites = favorites
    dataManager.saveFavorites()
  }
  
  func setButtonImage(imageName: String) {
    favoriteButtonImageName = imageName
    favoriteButton.setImage(UIImage(named: imageName)!,forState:UIControlState.Normal)
  }
  
}