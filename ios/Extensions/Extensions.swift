//
//  Extensions.swift
//  NativeVision
//
//  Created by Duong Phuong on 30/7/25.
//

import UIKit

extension UIImage {
  func resized(to newSize: CGSize) -> UIImage {
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
