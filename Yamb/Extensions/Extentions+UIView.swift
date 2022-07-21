//
//  Extentions+UIView.swift
//  Yamb
//
//  Created by Ana Peshevska on 18.7.22.
//

import UIKit

extension UIView {
  
  func shake() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.05
    animation.repeatCount = 2
    animation.autoreverses = true
      animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
      animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
      self.layer.add(animation, forKey: "position")
  }

}
