//
//  RCTAudioModule.swift
//  NativeVision
//
//  Created by Duong Phuong on 6/8/25.
//

import UIKit
import React
import AVFoundation

@objc(RCTAudioModule)
class RCTAudioModule: NSObject, RCTBridgeModule {
  
  let networkService = NetworkService.share
  var audioPlayer: AVAudioPlayer?
  
  static func moduleName() -> String! {
    return "AudioModule"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc func playMusic(_ url: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
    networkService.getData(urlString: url) { data, error in
      if let error = error {
        print(error)
        let title = "Failed"
        let message = "Can not get music!"
        DispatchQueue.main.async {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
          let okAction = UIAlertAction(title: "Ok", style: .default)
          alert.addAction(cancelAction)
          alert.addAction(okAction)
          reject(title, message, error)
          guard let rootVC = self.getRootVC() else {
            return
          }
          rootVC.present(alert, animated: true)
        }
        return
      }
      
      guard let data = data else {
        print("Bad data!")
        return reject("Failed", "Bad data", nil)
      }
      
      do {
        self.audioPlayer = try AVAudioPlayer(data: data)
        self.audioPlayer?.prepareToPlay()
        self.audioPlayer?.play()
        return resolve("Success")
      } catch {
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Failed", message: "Can not play music!", preferredStyle: .alert)
          
          let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
          let okButton = UIAlertAction(title: "Ok", style: .default)
          alert.addAction(cancelButton)
          alert.addAction(okButton)
          guard let rootVC = self.getRootVC() else {
            return
          }
          rootVC.present(alert, animated: true)
        }
        reject("Failed", "Can not play music!", nil)
      }
    }
  }
  
  private func getRootVC() -> UIViewController? {
    guard let vc = UIApplication.shared.delegate?.window??.rootViewController else {
      print("RootVC is not available!")
      return nil
    }
    return vc
  }
  
  
}
