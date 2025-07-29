//
//  RCTTimeModule.swift
//  LinkingApp
//
//  Created by Duong Phuong on 24/7/25.
//

import UIKit
import React

@objc(RCTCameraModule)
class RCTCameraModule: NSObject, RCTBridgeModule {
  
  private var currentResolve: RCTPromiseResolveBlock?
  private var currentReject: RCTPromiseRejectBlock?
  
  static func moduleName() -> String! {
    return "CameraModule"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  func openPreview(_ resolve: @escaping RCTPromiseResolveBlock,
                   rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    self.currentResolve = resolve
    self.currentReject = reject
    DispatchQueue.main.async { // Ensure UI operations are on the main thread
      // 1. Get the currently presented view controller
      // RCTPresentedViewController() is a React Native helper to get the top-most view controller.
      guard let rootViewController = UIApplication.shared.delegate?.window??.rootViewController else {
        print("No root view controller found to present from.")
        return
      }
      
      // Find the currently presented view controller if there's a modal chain
      var topViewController = rootViewController
      while let presentedVC = topViewController.presentedViewController {
        topViewController = presentedVC
      }
      
      // 2. Create an instance of your new native screen
      let navController = CameraViewController()
      navController.delegate = self
      navController.modalPresentationStyle = .fullScreen
      
      topViewController.present(navController, animated: true)
      
      print("Native screen 'MyNewNativeViewController' presented.")
    }
  }
}

extension RCTCameraModule: CameraViewControllerDelegate {
  func getImage(_ view: CameraViewController, image: UIImage) {
    currentResolve?("Day la Image")
    let data = image.jpegData(compressionQuality: 1)?.base64EncodedData()
    currentReject = nil
  }
}
