//
//  Location.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 11/18/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject, NSCoding {
  
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  var locationManager = CLLocationManager()
  
  override init() {
    self.latitude = 0.00
    self.longitude = 0.00
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeDoubleForKey("Latitude") as CLLocationDegrees
    self.longitude = aDecoder.decodeDoubleForKey("Longitude") as CLLocationDegrees
    super.init()
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeDouble(self.latitude, forKey: "Latitude")
    aCoder.encodeDouble(self.longitude, forKey: "Longitude")
  }
  
  func getCurrentLocation() {
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
    if let currLocation = locationManager.location {
      self.latitude = currLocation.coordinate.latitude
      self.longitude = currLocation.coordinate.longitude
    }
  }
  
}