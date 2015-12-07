//
//  CircleView.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit

class CircleView: UIView {
  
  var color : UIColor = UIColor.blackColor()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  class func initWithColor(color: UIColor) {
    
  }
  
  override func drawRect(rect: CGRect) {
    var path = UIBezierPath(ovalInRect: rect)
    color.setFill()
    path.fill()
  }
}