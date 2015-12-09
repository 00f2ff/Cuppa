//
//  RectangleLayer.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/8/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit

class RectangleLayer: CAShapeLayer {
  
  override init!() {
    super.init()
    fillColor = UIColor.clearColor().CGColor
    lineWidth = 5.0
    path = rectanglePathFull.CGPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var rectanglePathFull: UIBezierPath {
    var rectanglePath = UIBezierPath()
    rectanglePath.moveToPoint(CGPoint(x: lineWidth / 2, y: 100.0))
    rectanglePath.addLineToPoint(CGPoint(x: lineWidth / 2, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: -lineWidth))
    rectanglePath.addLineToPoint(CGPoint(x: 100.0, y: 100.0))
    rectanglePath.addLineToPoint(CGPoint(x: lineWidth / 2, y: 100.0))
    rectanglePath.closePath()
    return rectanglePath
  }
  
  func draw() {
    strokeColor = UIColor.blackColor().CGColor
  }

}

