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
    
    cameraPreviewView.layer.addSublayer(videoPreviewLayer)
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.captureSession.startRunning()
    }
    
    DispatchQueue.main.async {
      self.videoPreviewLayer.frame = self.cameraPreviewView.bounds
    }
  }
  
  func setupActionButton() {
    
    let stackViewFooter = UIStackView()
    stackViewFooter.axis = .horizontal
    stackViewFooter.distribution = .fillEqually
    stackViewFooter.alignment = .center
    stackViewFooter.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.addSubview(stackViewFooter)
    
    let pictureCollectionView = UIView()
    pictureCollectionView.translatesAutoresizingMaskIntoConstraints = false
    pictureCollectionView.backgroundColor = .red
    pictureCollectionView.layer.cornerRadius = 5
    
    let leftView = UIView()
    leftView.addSubview(pictureCollectionView)
    leftView.translatesAutoresizingMaskIntoConstraints = false
    leftView.backgroundColor = .blue
    stackViewFooter.addArrangedSubview(leftView)
    
    // Capture Button
    let activeButtonImage = UIImage(named: "capture-button")
    let inactiveButtonImage = UIImage(named: "capture-button-2")
    
    let captureButton = UIButton()
    captureButton.setImage(activeButtonImage, for: .normal)
    captureButton.setImage(inactiveButtonImage, for: .highlighted)
    captureButton.translatesAutoresizingMaskIntoConstraints = false
    captureButton.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
    
    let centerView = UIView()
    centerView.addSubview(captureButton)
    centerView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(centerView)
    
    let doneButton = UIButton(type: .system)
    doneButton.setTitle("Done", for: .normal)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    
    let rightView = UIView()
    rightView.addSubview(doneButton)
    rightView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(rightView)
    
    // Auto Constraint for StackView
    NSLayoutConstraint.activate([
      pictureCollectionView.heightAnchor.constraint(equalToConstant: 50),
      pictureCollectionView.widthAnchor.constraint(equalToConstant: 50),
      pictureCollectionView.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
      pictureCollectionView.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
      
      captureButton.heightAnchor.constraint(equalToConstant: 64),
      captureButton.widthAnchor.constraint(equalToConstant: 64),
      captureButton.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
      captureButton.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
      
      doneButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
      doneButton.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
    ])
    
    let flashButton = UIButton()
    flashButton.setImage(UIImage(systemName: "flashlight.off.fill")?.withTintColor(.systemBlue).withRenderingMode(.alwaysOriginal), for: .normal)
    flashButton.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.addSubview(flashButton)
    print("Camera preview view interaction: \(cameraPreviewView.isUserInteractionEnabled)")
    print("Stack view footer interaction: \(stackViewFooter.isUserInteractionEnabled)")
    print("Left view interaction: \(leftView.isUserInteractionEnabled)")
    print("Capture button interaction: \(captureButton.isUserInteractionEnabled)")
    NSLayoutConstraint.activate([
      flashButton.topAnchor.constraint(equalTo: cameraPreviewView.topAnchor, constant: 20),
      flashButton.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor, constant: 20),
      
      stackViewFooter.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor),
      stackViewFooter.trailingAnchor.constraint(equalTo: cameraPreviewView.trailingAnchor),
      stackViewFooter.bottomAnchor.constraint(equalTo: cameraPreviewView.bottomAnchor, constant: -20),
      stackViewFooter.heightAnchor.constraint(equalToConstant: 80)
    ])
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
