//
//  RCTTimeModule.swift
//  LinkingApp
//
//  Created by Duong Phuong on 24/7/25.
//

import UIKit
import React
import AVFoundation

@objc(RCTCameraModule)
class RCTCameraModule: NSObject, RCTBridgeModule {
  
  private var currentResolve: RCTPromiseResolveBlock?
  private var currentReject: RCTPromiseRejectBlock?
  
  let networkService = NetworkService.share
  var audioPlayer: AVAudioPlayer?
  
  static func moduleName() -> String! {
    return "CameraModule"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  func nativePrinter(_ message: String) {
    print(message)
  }
  
  @objc
  func openCamera(_ resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    self.currentResolve = resolve
    self.currentReject = reject
    DispatchQueue.main.async {
      // Run on Main thread
      // Get the currently presented view controller
      guard let rootViewController = self.getRootVC() else {
        return
      }
      
      // Find the currently presented view controller if there's a modal chain
      var topViewController = rootViewController
      while let presentedVC = topViewController.presentedViewController {
        topViewController = presentedVC
      }
      
      let navController = CameraViewController()
      navController.delegate = self
      navController.modalPresentationStyle = .fullScreen
      
      topViewController.present(navController, animated: true)
      
    }
  }
  
  @objc func playMusic(_ url: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
    networkService.getData(urlString: url) { data, error in
      if let error = error {
        reject("Failed", "Get music!", error)
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Failed", message: "Can not get music!", preferredStyle: .alert)
          
          let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
          let okButton = UIAlertAction(title: "Ok", style: .default)
          alert.addAction(cancelButton)
          alert.addAction(okButton)
          guard let rootVC = self.getRootVC() else {
            return
          }
          rootVC.present(alert, animated: true)
        }
        return
      }
      guard let data = data else {
        print("Bad data")
        return
      }
      do {
        self.audioPlayer = try AVAudioPlayer(data: data)
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
        resolve("Success")
      } catch {
        reject("Failed", "Play music", nil)
      }
    }
  }
  
  private func getRootVC() -> UIViewController? {
    guard let rootVC = UIApplication.shared.delegate?.window??.rootViewController else {
      print("No root view controller found to present from!")
      return nil
    }
    return rootVC
  }
  
  
}

extension RCTCameraModule: CameraViewControllerDelegate {
  func getImage(_ view: CameraViewController,_ imageUri: String) {
    currentResolve?(imageUri)
    currentReject = nil
  }
}
