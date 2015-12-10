//
//  SecondViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // OUTLETS
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var sortButton: UIBarButtonItem!
  
  
  // ACTIONS
  @IBAction func changeSort(sender: UIBarButtonItem) {
    if sortButton.title == "Category" {
      sortButton.title = "A-Z"
      // sort drinks by category (only perform computation once)
      if let cd = categorizedDrinks {
        self.drinks = cd
      } else {
        var coffeeDrinks : [Drink] = []
        var espressoDrinks : [Drink] = []
        var flavoredDrinks : [Drink] = []
        // should be alphabetized by default
        for drink in self.drinks {
          if drink.category == "Coffee" {
            coffeeDrinks.append(drink)
          } else if drink.category == "Espresso" {
            espressoDrinks.append(drink)
          } else if drink.category == "Flavored" {
            flavoredDrinks.append(drink)
          }
        }
        categorizedDrinks = coffeeDrinks + espressoDrinks + flavoredDrinks
        drinks = categorizedDrinks!
      }
    } else {
      sortButton.title = "Category"
      // sort drinks alphabetically
      drinks = alphabeticalDrinks
    }
    self.tableView.reloadData()
  }
  
  
  // VARIABLES
  let textCellIdentifier = "DrinkCell"
  var drinks : [Drink] = []
  var alphabeticalDrinks : [Drink] = [] // default
  var categorizedDrinks : [Drink]? // set on first switch
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // preload JSON to speed up refreshOptions()
    DataManager.getDrinkDataWithSuccess { (data) -> Void in
      let json = JSON(data: data)
      self.convertToDrinks(json["drinks"])
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
    if segue.identifier == "drinkSegueFromList" {
      let dvc : DrinkViewController = segue.destinationViewController as! DrinkViewController
      let cell = sender as! DrinkCell
      let row = tableView.indexPathForCell(cell)!.row
      let selectedDrink = drinks[row]
      dvc.drink = selectedDrink
    }
  }
  
  
  // FUNCTIONS
  func convertToDrinks(jsonDrinks: JSON) {
    var ingredients : [Ingredient] = []
    for i in 0...jsonDrinks.count-1 {
      for (index, ingredient) in jsonDrinks[i]["ingredients"] {
        ingredients.append(Ingredient(name: ingredient["name"].string!, amount: ingredient["amount"].int!))
      }
      alphabeticalDrinks.append(Drink(name: jsonDrinks[i]["name"].string!, category: jsonDrinks[i]["category"].string!, image: jsonDrinks[i]["image"].string!, favorite: jsonDrinks[i]["favorite"].bool!, ingredients: ingredients, details: jsonDrinks[i]["details"].string!))
      // reset ingredients
      ingredients = []
    }
    // alphabetize
    alphabeticalDrinks.sort({ return $0.name < $1.name })
    // set alphabetical to current
    drinks = alphabeticalDrinks
    self.tableView.reloadData()
  }


}

