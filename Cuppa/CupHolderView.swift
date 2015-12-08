//
//  CupHolderView.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import Foundation
import UIKit

class CupHolderView : UIView {
  
  let arcLayer = ArcLayer()
  
  var parentFrame : CGRect = CGRectZero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clearColor()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func drawArc() {
    layer.addSublayer(arcLayer)
    arcLayer.animate()
  }
  
  
}
