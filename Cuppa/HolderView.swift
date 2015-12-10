//
//  HolderView.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/9/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//  Based off of work by Satraj Bambra

import UIKit

protocol HolderViewDelegate : class {
  func removeHolderFromView()
}

class HolderView: UIView {
  
  var parentFrame : CGRect = CGRectZero
  weak var delegate : HolderViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clearColor()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func drawArc() {
    var arcLayer = ArcLayer(width: frame.size.width, height: frame.size.height)
    layer.addSublayer(arcLayer)
    arcLayer.animate()
    // wait for animation to finish before fading in label
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "drawText",
      userInfo: nil, repeats: false)
  }
  
  func drawText() {
//    var cuppaTextLayer = CuppaTextLayer()
    var label = CATextLayer()
    label.fontSize = 20
    label.string = "Cuppa"
    label.alignmentMode = kCAAlignmentCenter
    label.foregroundColor = UIColor.clearColor().CGColor
    layer.addSublayer(label)
    // animate color in
    UIView.animateWithDuration(1, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
      self.frame = self.parentFrame
      }, completion: { finished in
        self.removeHolderFromView()
    })
  }
  
  func removeHolderFromView() {
    delegate?.removeHolderFromView()
  }
  
//  func expandView() {
//    backgroundColor = Colors.blue
//    frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth,
//      frame.origin.y - blueRectangleLayer.lineWidth,
//      frame.size.width + blueRectangleLayer.lineWidth * 2,
//      frame.size.height + blueRectangleLayer.lineWidth * 2)
//    layer.sublayers = nil
//    
//    UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//      self.frame = self.parentFrame
//      }, completion: { finished in
//        self.addLabel()
//    })
//  }
  
//  func addLabel() {
//    delegate?.animateLabel()
//  }
  
}

