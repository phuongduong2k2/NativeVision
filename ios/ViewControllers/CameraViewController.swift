//
//  CustomCameraViewController.swift
//  LinkingApp
//
//  Created by Duong Phuong on 25/7/25.
//

import UIKit
import AVFoundation

protocol CameraViewControllerDelegate: AnyObject {
  func getImage(_ view: CameraViewController,_ imageUri: String)
}

class CameraViewController: CameraView {
  
  var captureSession: AVCaptureSession!
  var photoOutput: AVCapturePhotoOutput!
  var videoPreviewLayer: AVCaptureVideoPreviewLayer!
  
  weak var delegate: CameraViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Request permissions first
    checkCameraPermissions()
  }
  
  func checkCameraPermissions() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      setupCamera()
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
          DispatchQueue.main.async {
            self.setupCamera()
          }
        } else {
          self.showPermissionAlert()
        }
      }
    case .denied, .restricted:
      showPermissionAlert()
    @unknown default:
      fatalError("Unknown authorization status")
    }
  }
  
  func setupCamera() {
    captureSession = AVCaptureSession()
    captureSession.beginConfiguration()
    captureSession.sessionPreset = .photo
    
    guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      print("Unable to access back camera!")
      return
    }
    
    do {
      let input = try AVCaptureDeviceInput(device: backCamera)
      
      photoOutput = AVCapturePhotoOutput()
      
      if photoOutput.isLivePhotoCaptureSupported {
        photoOutput.isLivePhotoCaptureEnabled = true
      }
      if photoOutput.isDepthDataDeliverySupported {
        photoOutput.isDepthDataDeliveryEnabled = true
      }
      
      if captureSession.canAddInput(input) && captureSession.canAddOutput(photoOutput) {
        captureSession.addInput(input)
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        startRun()
        setupLivePreview()
        setupFooterButtons()
        setupHeaderButtons()
      } else {
        print("Could not add input or output to session")
      }
    } catch let error {
      print("Error setting up camera input: \(error.localizedDescription)")
    }
  }
  
  func setupLivePreview() {
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    videoPreviewLayer.videoGravity = .resizeAspectFill
    videoPreviewLayer.connection?.videoOrientation = .portrait // Set initial orientation
    
    cameraPreviewView.layer.addSublayer(videoPreviewLayer)
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.captureSession.startRunning()
    }
    
    DispatchQueue.main.async {
      self.videoPreviewLayer.frame = self.cameraPreviewView.bounds
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // Ensure the preview layer updates its frame when the view layout changes
    videoPreviewLayer?.frame = cameraPreviewView.bounds
  }
  
  private func startRun() {
    if !captureSession.isRunning {
      DispatchQueue.global(qos: .userInitiated).async {
        self.captureSession.startRunning()
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopRun()
  }
  
  private func stopRun() {
    if captureSession.isRunning {
      DispatchQueue.global(qos: .userInitiated).async {
        self.captureSession.stopRunning()
      }
    }
  }
  
  func showPermissionAlert() {
    let alert = UIAlertController(title: "Camera Access Required",
                                  message: "Please enable camera access in Settings to use this feature.",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
      if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
      }
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  override func captureButtonTapped() {
    let settings = AVCapturePhotoSettings()
    if flashButton.isSelected {
      settings.flashMode = .on
    } else {
      settings.flashMode = .off
    }
    photoOutput.capturePhoto(with: settings, delegate: self)
  }
  
  override func closeButtonTapped() {
    dismiss(animated: true)
  }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if let error = error {
      print("Error capturing photo: \(error.localizedDescription)")
      return
    }
    
    guard let imageData = photo.fileDataRepresentation() else {
      print("No image data found.")
      return
    }
    
    // Convert data to UIImage
    
    stopRun()
    let vc = PreviewImageViewController()
    vc.delegate = self
    vc.imageData = imageData
    present(vc, animated: true)
  }
  
}

extension CameraViewController: PreviewImageViewControllerDelegate {
  func done(_ view: PreviewImageViewController) {
    startRun()
  }
  
  func selectedImage(_ view: PreviewImageViewController,_ imageUri: String) {
    delegate?.getImage(self, imageUri)
  }
}
