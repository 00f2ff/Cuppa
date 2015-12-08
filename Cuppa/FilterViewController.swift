//
//  FirstViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit
import ChameleonFramework

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // OUTLETS
  @IBOutlet weak var categoryControl: UISegmentedControl!
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var mainSlider: UISlider!
  @IBOutlet weak var secondaryLabel: UILabel!
  @IBOutlet weak var secondarySlider: UISlider!
  @IBOutlet weak var tableView: UITableView!
  
  
  // ACTIONS
  @IBAction func segmentChanged(sender : UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      updateUI("Coffee")
    case 1:
      updateUI("Espresso")
    default:
      break;
    }
  } // segmentChanged
  
  
  @IBAction func sliderValueChanged(sender: UISlider) {
    // calculate if there was a change in either value, thus requiring refreshed results
    // modify slider values to fit data (some of these modifications are unnecessary as they cover 'Flavored' category
    var mainVolume : Int = 0
    if self.category == "Coffee" {
      // range: 6,8,_,_,10,11,12
      mainVolume = Int(round(self.mainSlider.value * 6.0)) + 6 // 12 is full cup of coffee
      // deal with missing values
      if mainVolume == 7 {
        mainVolume = 6
      } else if mainVolume == 9 {
        mainVolume = 10
      }
    } else {
      if self.mainSlider.value <= 0.5 {
        mainVolume = 1
      } else {
        mainVolume = 2
      }
    }
    var secondaryVolume : Int = Int(round(self.secondarySlider.value * 10.0))
    // range: 0,1,_,_,_,5,6,_,_,9,10
    // deal with missing values
    if secondaryVolume == 2 {
      secondaryVolume = 1
    } else if secondaryVolume > 2 && secondaryVolume < 5 {
      secondaryVolume = 5
    } else if secondaryVolume == 7 {
      secondaryVolume = 6
    } else if secondaryVolume == 8 {
      secondaryVolume = 9
    } else if secondaryVolume == 9 {
      secondaryVolume = 10 // 9 is valid, but needs to be cohesive
    }
    if self.mainVolume != mainVolume || self.secondaryVolume != secondaryVolume {
      self.mainVolume = mainVolume
      self.secondaryVolume = secondaryVolume
      refreshOptions()
    }
  } // sliderValueChanged
  
  
  // VARIABLES
  let textCellIdentifier = "DrinkCell"
  var category: String = "Coffee"
  var drinks: JSON = []
  var drinkResults : [Drink] = []
  var mainVolume : Int = 0
  var secondaryVolume : Int = 0
  
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    // preload JSON to speed up refreshOptions()
    DataManager.getDrinkDataWithSuccess { (data) -> Void in
      let json = JSON(data: data)
      self.drinks = json["drinks"]
    }
    
    tableView.delegate = self
    tableView.dataSource = self
    // remove extra lines at bottom
    tableView.tableFooterView = UIView()
    tableView.backgroundColor = UIColor.clearColor()
//    let gradientColor = GradientColor(UIGradientStyle.TopToBottom, view.frame, [FlatBrownDark(), FlatWhite()])
    tableView.separatorColor = UIColor.clearColor()
    self.view.backgroundColor = FlatBrownDark()
    
  } // viewDidLoad

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  } // didReceiveMemoryWarning
  
  
  // DELEGATION
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1 // init as 0?
  } // numberOfSectionsInTableView
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return drinkResults.count
  } // tableView
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("DrinkCell") as! DrinkCell
    let drink = drinkResults[indexPath.row]
    // handle image later
    cell.nameLabel.text = drink.name
//    if category == "Coffee" {
//      cell.backgroundColor = FlatBrownDark()
//    } else {
//      cell.backgroundColor = FlatBrown()
//    }
    
    
    return cell
  } // tableView
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  } // tableView
  
  
  // SEGUES
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "drinkSegue" {
      let dvc : DrinkViewController = segue.destinationViewController as! DrinkViewController
      let cell = sender as! DrinkCell
      let row = tableView.indexPathForCell(cell)!.row
      let selectedDrink = drinkResults[row]
      dvc.drink = selectedDrink
    }
  }
  
  // FUNCTIONS
  func updateUI(category: String) {
    self.category = category
    self.mainLabel.text = "\(category) Volume"
    // reset slider values
    UIView.animateWithDuration(0.5, animations: {
      self.mainSlider.setValue(0.5, animated: true)
      self.secondarySlider.setValue(0.5, animated: true)
      if category == "Coffee" {
        self.view.backgroundColor = FlatBrownDark()
//        self.tableView.backgroundColor = FlatBrownDark()
//        for i in 0...self.tableView.visibleCells().count-1 {
//          self.tableView.visibleCells()[i].view!!.backgroundColor = FlatBrownDark()
//        }
//        for i in 0...self.tableView.numberOfSections()-1 {
//          for j in 0...self.tableView.numberOfRowsInSection(i) {
//            self.tableView.cellForRowAtIndexPath(indexpa)
//          }
//        }
//        self.mainSlider.thumbTintColor = FlatBrown()
      } else {
        self.view.backgroundColor = FlatBrown()
//        self.tableView.backgroundColor = FlatBrown()
//        for i in 0...self.tableView.visibleCells().count-1 {
//          println( self.tableView.visibleCells()[i])
//          self.tableView.visibleCells()[i]
//          .view!!.backgroundColor = FlatBrown()
//        }
//        self.mainSlider.thumbTintColor = FlatBrownDark()
      }
      }, completion: { (complete: Bool) in
        self.drinkResults = []
        self.tableView.reloadData()
      })
//    refreshOptions()
    
  } // updateUI
  
  func refreshOptions() {
    drinkResults = []
    var ingredients : [Ingredient] = []
    var mainBool : Bool = false
    var secondaryBool : Bool = false
    var hasSecondary : Bool = false
    for i in 0...self.drinks.count-1 {
      for (index, ingredient) in self.drinks[i]["ingredients"] {
        if ingredient["name"].string == "Espresso" {
          // check main
          if ingredient["amount"].int == self.mainVolume {
            mainBool = true
          }
        } else if ingredient["name"].string == "Coffee" { // provide range
          if ingredient["amount"].int >= self.mainVolume - 1 && ingredient["amount"].int <= self.mainVolume + 1 {
            mainBool = true
          }
          // check secondary
        } else if ingredient["name"].string == "Milk" {
          if ingredient["amount"].int >= self.secondaryVolume - 1 && ingredient["amount"].int <= self.secondaryVolume + 1  { // provide range
            secondaryBool = true
            hasSecondary = true
          }
        }
      }
      // if both are true, make a drink
      // there may be a more efficient way to do this
      // second boolean statement checks if the volume is 0 and the drink doesn't have it
      if mainBool && (secondaryBool || (self.secondaryVolume == 0 && !hasSecondary)) {
        for (index, ingredient) in self.drinks[i]["ingredients"] {
          ingredients.append(Ingredient(name: ingredient["name"].string!, amount: ingredient["amount"].int!))
        }
        drinkResults.append(Drink(name: self.drinks[i]["name"].string!, category: self.drinks[i]["category"].string!, image: self.drinks[i]["image"].string!, favorite: self.drinks[i]["favorite"].bool!, ingredients: ingredients, details: self.drinks[i]["details"].string!))
        // reset ingredients
        ingredients = []
        mainBool = false
        secondaryBool = false
        hasSecondary = false
      }
    }
    //    }
    self.tableView.reloadData()
  } // refreshOptions

}

