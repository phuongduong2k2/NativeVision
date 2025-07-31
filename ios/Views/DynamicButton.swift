//
//  AppButton.swift
//  NativeVision
//
//  Created by Duong Phuong on 30/7/25.
//

import UIKit

class DynamicButton: UIButton {
  
  private var activeImage: UIImage?
  private var inactiveImage: UIImage?
  private var rotationAngle: CGFloat?
  
  var toggleValue: Bool = false {
    didSet {
      updateApperance()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    self.addTarget(self, action: #selector(toggleState), for: .touchUpInside)
  }
  
  private func updateApperance() {
    if toggleValue {
      self.setImage(activeImage, for: .normal)
    } else {
      self.setImage(inactiveImage, for: .normal)
    }
    UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
  }
  
  func configure(activeImage: UIImage?, inactiveImage: UIImage?, initialState: Bool = false, rotationAngle: CGFloat? = 0) {
    self.toggleValue = initialState
    self.activeImage = activeImage
    self.inactiveImage = inactiveImage
    self.rotationAngle = rotationAngle
    self.setImage(inactiveImage, for: .normal)
  }
  
  @objc private func toggleState() {
    toggleValue = !toggleValue
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    UIView.animate(withDuration: 0.2) {
      self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    UIView.animate(withDuration: 0.2) {
      self.transform = CGAffineTransform(scaleX: 1, y: 1)
      if let rotationAngle = self.rotationAngle {
        self.transform = CGAffineTransform(rotationAngle: self.toggleValue ? rotationAngle : 0)
      }
    } 
  }
}
