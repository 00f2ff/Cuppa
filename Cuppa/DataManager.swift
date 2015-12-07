//
//  DataManager.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/2/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation

class DataManager {
  
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