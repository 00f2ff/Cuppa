//
//  CuppaTextLayer.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/9/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//

import UIKit

class CuppaTextLayer : CATextLayer {
  
  init(width: CGFloat, height: CGFloat) {
    super.init()
    string = "Cuppa"
    fontSize = 20
    alignmentMode = kCAAlignmentCenter
    foregroundColor = UIColor.clearColor().CGColor
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
