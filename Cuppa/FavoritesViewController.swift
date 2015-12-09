//
//  FavoritesViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/9/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit
//import ChameleonFramework

class FavoritesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // OUTLETS
  @IBOutlet weak var tableView: UITableView!
  
  
  // ACTIONS
  
  
  // VARIABLES
  var favorites = [String]()
  let textCellIdentifier = "DrinkCell"
  var drinks : [Drink] = []
  let dataManager = DataManager()
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    println("favorites")
    // Do any additional setup after loading the view, typically from a nib.
    // preload JSON to speed up refreshOptions()
    loadData()
    
    tableView.delegate = self
    tableView.dataSource = self
    // remove extra lines at bottom
    tableView.tableFooterView = UIView()
    tableView.separatorColor = UIColor.clearColor()
  }
  
//  override func viewWillAppear(animated: Bool) {
//    favorites = []
//    loadData()
//    super.viewWillAppear(false)
//  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // DELEGATION
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  } // numberOfSectionsInTableView
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return drinks.count
  } // tableView
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("DrinkCell") as! DrinkCell
    let drink = drinks[indexPath.row]
    // handle image later
    cell.nameLabel.text = drink.name
    return cell
  } // tableView
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  } // tableView
  
  
  // SEGUES
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "drinkSegueFromFavorites" {
      let dvc : DrinkViewController = segue.destinationViewController as! DrinkViewController
      let cell = sender as! DrinkCell
      let row = tableView.indexPathForCell(cell)!.row
      let selectedDrink = drinks[row]
      dvc.drink = selectedDrink
    }
  }
  
  
  // FUNCTIONS
  func loadData() {
    DataManager.getDrinkDataWithSuccess { (data) -> Void in
      let json = JSON(data: data)
      self.dataManager.loadFavorites()
      self.favorites = self.dataManager.favorites
      self.convertToDrinks(json["drinks"]) // this method only adds favorited drinks to self.drinks
      dispatch_async(dispatch_get_main_queue()) {
        self.tableView.reloadData()
      }
    }
  }
  
  func convertToDrinks(jsonDrinks: JSON) {
    var ingredients : [Ingredient] = []
    for i in 0...jsonDrinks.count-1 {
      // check favorite status
      if contains(favorites, jsonDrinks[i]["name"].string!) {
        for (index, ingredient) in jsonDrinks[i]["ingredients"] {
          ingredients.append(Ingredient(name: ingredient["name"].string!, amount: ingredient["amount"].int!))
        }
        drinks.append(Drink(name: jsonDrinks[i]["name"].string!, category: jsonDrinks[i]["category"].string!, image: jsonDrinks[i]["image"].string!, favorite: jsonDrinks[i]["favorite"].bool!, ingredients: ingredients, details: jsonDrinks[i]["details"].string!))
        // reset ingredients
        ingredients = []
      }
    }
    // alphabetize
    drinks.sort({ return $0.name < $1.name })
    self.tableView.reloadData()
  }

  
  
  
}