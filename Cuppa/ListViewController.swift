//
//  SecondViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  let textCellIdentifier = "DrinkCell"
  var drinks : [Drink] = []
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // preload JSON to speed up refreshOptions()
    DataManager.getDrinkDataWithSuccess { (data) -> Void in
      let json = JSON(data: data)
      self.convertToDrinks(json["drinks"])
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
  
  // DELEGATION
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1 // init as 0?
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
      self.drinks.append(Drink(name: jsonDrinks[i]["name"].string!, category: jsonDrinks[i]["category"].string!, image: jsonDrinks[i]["image"].string!, favorite: jsonDrinks[i]["favorite"].bool!, ingredients: ingredients, details: jsonDrinks[i]["details"].string!))
      // reset ingredients
      ingredients = []
    }
  }


}

