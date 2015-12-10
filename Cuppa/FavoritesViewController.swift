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
  var allDrinks : [Drink] = []
  let dataManager = DataManager()
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    println("favorites")
    // Do any additional setup after loading the view, typically from a nib.
    DataManager.getDrinkDataWithSuccess { (data) -> Void in
      self.dataManager.loadFavorites()
      self.favorites = self.dataManager.favorites
      let json = JSON(data: data)
      self.convertToDrinks(json["drinks"])
      self.selectFavorites()
      dispatch_async(dispatch_get_main_queue()) {
        self.tableView.reloadData()
      }
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    // remove extra lines at bottom
    tableView.tableFooterView = UIView()
    tableView.separatorColor = UIColor.clearColor()
  }
  
  override func viewWillAppear(animated: Bool) {
    self.dataManager.loadFavorites()
    self.favorites = self.dataManager.favorites
    self.selectFavorites()
    dispatch_async(dispatch_get_main_queue()) {
      self.tableView.reloadData()
    }
    super.viewWillAppear(false)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // only permit portrait
  override func shouldAutorotate() -> Bool {
    return false
  }
  
  override func supportedInterfaceOrientations() -> Int {
    return UIInterfaceOrientation.Portrait.rawValue
  }
  
  
  // DELEGATION
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1 // could be used for better sorting in list
  } // numberOfSectionsInTableView
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return drinks.count
  } // tableView
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("DrinkCell") as! DrinkCell
    let drink = drinks[indexPath.row]
    // handle image later
    cell.nameLabel.text = drink.name
    if drink.category == "Coffee" {
      cell.drinkImageView.image = UIImage(named: "Coffee-32-black.png")
    } else if drink.category == "Espresso" {
      cell.drinkImageView.image = UIImage(named: "Espresso-black.png")
    } else {
      cell.drinkImageView.image = UIImage(named: "Flavored-black.png")
    }
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
//    DataManager.getDrinkDataWithSuccess { (data) -> Void in
//      let json = JSON(data: data)
//      self.dataManager.loadFavorites()
//      self.favorites = self.dataManager.favorites
//      self.convertToDrinks(json["drinks"])
//      self.selectFavorites()
//      dispatch_async(dispatch_get_main_queue()) {
//        self.tableView.reloadData()
//      }
//    }
  }
  
  func convertToDrinks(jsonDrinks: JSON) {
    var ingredients : [Ingredient] = []
    for i in 0...jsonDrinks.count-1 {
      for (index, ingredient) in jsonDrinks[i]["ingredients"] {
        ingredients.append(Ingredient(name: ingredient["name"].string!, amount: ingredient["amount"].int!))
      }
      allDrinks.append(Drink(name: jsonDrinks[i]["name"].string!, category: jsonDrinks[i]["category"].string!, image: jsonDrinks[i]["image"].string!, favorite: jsonDrinks[i]["favorite"].bool!, ingredients: ingredients, details: jsonDrinks[i]["details"].string!))
      // reset ingredients
      ingredients = []
    }
    // alphabetize
//    allDrinks.sort({ return $0.name < $1.name })
//    self.tableView.reloadData()
  }
  
  func selectFavorites() {
    // reset drinks
    drinks = []
    for drink in allDrinks {
      if contains(favorites, drink.name) {
        drinks.append(drink)
      }
    }
    drinks.sort({ return $0.name < $1.name })
    self.tableView.reloadData()
  }
  


  
  
  
}