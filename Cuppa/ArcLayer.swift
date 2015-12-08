//
//  ArcLayer.swift
//  Cuppa
//
//  Created by Duncan McIsaac on 12/7/15.
//  Copyright (c) 2015 Duncan McIsaac. All rights reserved.
//  Based off of Satraj Bambra's work


import UIKit

class ArcLayer: CAShapeLayer {
  
  var animationDuration: CFTimeInterval = 1
  var width : CGFloat = 150.0
  var height : CGFloat = 150.0
//  var startHeight : CGFloat = 150.0 // gets multiplied by volumeRatio outside
  var volumeRatio : CGFloat = 1.0
  
  init(volumeRatio : CGFloat) {
    
    self.volumeRatio = volumeRatio
    self.animationDuration = self.animationDuration / (CFTimeInterval(1) - CFTimeInterval(self.volumeRatio))
    super.init()
    fillColor = UIColor.blueColor().CGColor
//    setPath()
    path = arcPathStarting.CGPath
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  func setPath() {
//    path = arcPathStarting.CGPath
//  }
  
  // points of each path. Endpoints are always max/min; inflections are along curve points
//  var arcPathPre: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * 0.99))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height * 0.99))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathPre: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.99))
    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio * 0.99))
    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathPre(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.99))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio * 0.99))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
//  var arcPathStarting: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * 0.80))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * 0.80), controlPoint1: CGPoint(x: width * 0.30, y: height * 0.70), controlPoint2: CGPoint(x: width * 0.40, y: height * 0.90))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathStarting: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.80))
    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.80), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.70), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.90))
    arcPath.addLineToPoint(CGPoint(x: width, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathStarting(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.80))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.80), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.70), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.90))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
//  var arcPathLow: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * 0.60))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * 0.60), controlPoint1: CGPoint(x: width * 0.30, y: height * 0.65), controlPoint2: CGPoint(x: width * 0.40, y: height * 0.50))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathLow: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.60))
    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.60), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.65), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.50))
    arcPath.addLineToPoint(CGPoint(x: width, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathLow(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.60))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.60), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.65), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.50))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
//  var arcPathMid: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: width * 0.40))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * 0.40), controlPoint1: CGPoint(x: width * 0.30, y: height * 0.30), controlPoint2: CGPoint(x: width * 0.40, y: height * 0.50))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathMid: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.40))
    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.40), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.30), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.50))
    arcPath.addLineToPoint(CGPoint(x: width, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathMid(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.40))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.40), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.30), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.50))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
//  var arcPathHigh: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * 0.20))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * 0.20), controlPoint1: CGPoint(x: width * 0.30, y: height * 0.25), controlPoint2: CGPoint(x: width * 0.40, y: height * 0.10))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathHigh: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.20))
    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.20), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.25), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.10))
    arcPath.addLineToPoint(CGPoint(x: width, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathHigh(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio * 0.20))
//    arcPath.addCurveToPoint(CGPoint(x: width, y: height * volumeRatio * 0.20), controlPoint1: CGPoint(x: width * 0.30, y: height * volumeRatio * 0.25), controlPoint2: CGPoint(x: width * 0.40, y: height * volumeRatio * 0.10))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
//  var arcPathComplete: UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: 0))
//    arcPath.addLineToPoint(CGPoint(x: width, y: 0))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  var arcPathComplete: UIBezierPath {
    var arcPath = UIBezierPath()
    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio)) // kind of a misnomer because it's a sum
    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio))
    arcPath.addLineToPoint(CGPoint(x: width, y: height))
    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
    arcPath.closePath()
    return arcPath
  }
  
//  func arcPathComplete(volumeRatio: CGFloat) -> UIBezierPath {
//    var arcPath = UIBezierPath()
//    arcPath.moveToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height * volumeRatio)) // kind of a misnomer because it's a sum
//    arcPath.addLineToPoint(CGPoint(x: width, y: height * volumeRatio))
//    arcPath.addLineToPoint(CGPoint(x: width, y: height))
//    arcPath.addLineToPoint(CGPoint(x: 0.0, y: height))
//    arcPath.closePath()
//    return arcPath
//  }
  
  // staggered animation creation
  func animate() {
    // set path with updated volumeRatio
//    setPath()
    
    var arcAnimationPre: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationPre.fromValue = arcPathPre.CGPath
    arcAnimationPre.toValue = arcPathStarting.CGPath
    arcAnimationPre.beginTime = 0.0
    arcAnimationPre.duration = animationDuration
    
    var arcAnimationLow: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationLow.fromValue = arcPathStarting.CGPath
    arcAnimationLow.toValue = arcPathLow.CGPath
    arcAnimationLow.beginTime = arcAnimationPre.beginTime + arcAnimationPre.duration
    arcAnimationLow.duration = animationDuration
    
    var arcAnimationMid: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationMid.fromValue = arcPathLow.CGPath
    arcAnimationMid.toValue = arcPathMid.CGPath
    arcAnimationMid.beginTime = arcAnimationLow.beginTime + arcAnimationLow.duration
    arcAnimationMid.duration = animationDuration
    
    var arcAnimationHigh: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationHigh.fromValue = arcPathMid.CGPath
    arcAnimationHigh.toValue = arcPathHigh.CGPath
    arcAnimationHigh.beginTime = arcAnimationMid.beginTime + arcAnimationMid.duration
    arcAnimationHigh.duration = animationDuration
    
    var arcAnimationComplete: CABasicAnimation = CABasicAnimation(keyPath: "path")
    arcAnimationComplete.fromValue = arcPathHigh.CGPath
    arcAnimationComplete.toValue = arcPathComplete.CGPath
    arcAnimationComplete.beginTime = arcAnimationHigh.beginTime + arcAnimationHigh.duration
    arcAnimationComplete.duration = animationDuration
    
    var arcAnimationGroup: CAAnimationGroup = CAAnimationGroup()
    arcAnimationGroup.animations = [arcAnimationPre, arcAnimationLow, arcAnimationMid,
      arcAnimationHigh, arcAnimationComplete]
    arcAnimationGroup.duration = arcAnimationComplete.beginTime + arcAnimationComplete.duration
    arcAnimationGroup.fillMode = kCAFillModeForwards
    arcAnimationGroup.removedOnCompletion = false
    addAnimation(arcAnimationGroup, forKey: nil)
  }
}

