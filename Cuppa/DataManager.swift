//
//  DataManager.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/2/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation

class DataManager {
  
  var favorites = [String]() // this of course assumes names are unique
  
  init() {
    loadFavorites()
  }
  
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent("Favorites.plist")
  }
  
  func saveFavorites() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(favorites, forKey: "Favorites")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadFavorites() {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        self.favorites = unarchiver.decodeObjectForKey("Favorites") as! [String]
        unarchiver.finishDecoding()
      }
    }
  }
  
  
  class func getDrinkDataWithSuccess(success: ((data: NSData) -> Void)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      let filePath = NSBundle.mainBundle().pathForResource("drinks",ofType:"json")
      
      var readError:NSError?
      if let data = NSData(contentsOfFile:filePath!,
        options: NSDataReadingOptions.DataReadingUncached,
        error:&readError) {
          success(data: data)
      }
    })
  }
}