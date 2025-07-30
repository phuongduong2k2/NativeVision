//
//  AppButton.swift
//  NativeVision
//
//  Created by Duong Phuong on 30/7/25.
//

import UIKit

class AppButton: UIButton {
  var isScaleAnimation: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    if isScaleAnimation {
      UIView.animate(withDuration: 0.2) {
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    
    if isScaleAnimation {
      UIView.animate(withDuration: 0.2) {
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
      }
    }
  }
  
  func rotate() {
    UIView.animate(withDuration: 0.5) {
      self.transform = CGAffineTransform(rotationAngle: 180)
    }
  }
}
