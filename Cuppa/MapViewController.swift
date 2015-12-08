//
//  MapViewController.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 11/18/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController : UIViewController {
  @IBOutlet weak var mapView : MKMapView!
  let location = Location()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    location.getCurrentLocation()
    let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
    centerMapOnLocation(initialLocation)
    
    let dropPin = MKPointAnnotation()
    dropPin.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    dropPin.title = "You Are Here"
    mapView.addAnnotation(dropPin)
  }
  
  let regionRadius: CLLocationDistance = 400
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}