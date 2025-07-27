//
//  CustomCameraViewController.swift
//  LinkingApp
//
//  Created by Duong Phuong on 25/7/25.
//

import UIKit
import AVFoundation

class CustomCameraViewController: UIViewController {
  
  var captureSession: AVCaptureSession!
  var photoOutput: AVCapturePhotoOutput!
  var videoPreviewLayer: AVCaptureVideoPreviewLayer!
  
  let cameraPreviewView = UIView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Request permissions first
    cameraPreviewView.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.backgroundColor = .black
    view.addSubview(cameraPreviewView)
    
    NSLayoutConstraint.activate([
      cameraPreviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      cameraPreviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      cameraPreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      cameraPreviewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
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
    captureSession.sessionPreset = .photo // Or .high, .hd1920x1080, etc.
    
    // Get default back camera
    guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      print("Unable to access back camera!")
      return
    }
    
    do {
      let input = try AVCaptureDeviceInput(device: backCamera)
      
      photoOutput = AVCapturePhotoOutput()
      // Enable Live Photo, Depth, etc., if desired
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
        
        setupLivePreview()
        setupActionButton()
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
    
    // Add the preview layer to your view
    cameraPreviewView.layer.addSublayer(videoPreviewLayer)
    
    // Start the session on a background queue
    DispatchQueue.global(qos: .userInitiated).async {
      self.captureSession.startRunning()
    }
    
    // Set the frame of the preview layer after the view's layout is complete
    DispatchQueue.main.async {
      self.videoPreviewLayer.frame = self.cameraPreviewView.bounds
    }
  }
  
  func setupActionButton() {
    let captureButton = UIButton(type: .system)
    captureButton.translatesAutoresizingMaskIntoConstraints = false
    captureButton.layer.cornerRadius = 35
    captureButton.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    captureButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
    cameraPreviewView.addSubview(captureButton)
    
    let testLabel = UILabel()
    testLabel.text = "Chạm để chụp"
    testLabel.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.addSubview(testLabel)
    
    NSLayoutConstraint.activate([
      captureButton.centerXAnchor.constraint(equalTo: cameraPreviewView.centerXAnchor),
      captureButton.bottomAnchor.constraint(equalTo: cameraPreviewView.bottomAnchor, constant: -20),
      captureButton.heightAnchor.constraint(equalToConstant: 70),
      captureButton.widthAnchor.constraint(equalToConstant: 70),
      
      testLabel.bottomAnchor.constraint(equalTo: captureButton.topAnchor, constant: -20),
      testLabel.centerXAnchor.constraint(equalTo: cameraPreviewView.centerXAnchor)
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // Ensure the preview layer updates its frame when the view layout changes
    videoPreviewLayer?.frame = cameraPreviewView.bounds
  }
  
  // Handle app coming to foreground/background to stop/start session
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startRun()
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
  
  @objc func takePhotoTapped(_ sender: UIButton) {
    let settings = AVCapturePhotoSettings()
    photoOutput.capturePhoto(with: settings, delegate: self)
  }
}

extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
  
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
    if let capturedImage = UIImage(data: imageData) {
      stopRun()
      let vc = PreviewCapturedImageViewController()
      vc.delegate = self
      vc.image = capturedImage
      present(vc, animated: true)
    }
  }
  
}

extension CustomCameraViewController: PreviewCapturedImageViewControllerDelegate {
  func done(_ view: PreviewCapturedImageViewController) {
    startRun()
  }
}
