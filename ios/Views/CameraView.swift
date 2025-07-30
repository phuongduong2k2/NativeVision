//
//  CustomCameraView.swift
//  NativeVision
//
//  Created by Duong Phuong on 28/7/25.
//
 
import UIKit
import Photos
import PhotosUI

class CameraView: UIViewController, UINavigationControllerDelegate {
  
  let cameraPreviewView = UIView()
  let flashButton = UIButton()
  let closeButton = UIButton()
  let galleryButton = UIButton()
  let rotateButton = AppButton()
  
  lazy var imagePickerVC: UIImagePickerController = {
    let vc = UIImagePickerController()
    vc.delegate = self
    return vc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Init camera screen
    cameraPreviewView.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.backgroundColor = .black
    view.addSubview(cameraPreviewView)
    
    NSLayoutConstraint.activate([
      cameraPreviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      cameraPreviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      cameraPreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      cameraPreviewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.getLastestImageFromGallery()
    }
  }
  
  func setupFooterButtons() {
    
    let stackViewFooter = UIStackView()
    stackViewFooter.axis = .horizontal
    stackViewFooter.distribution = .fillEqually
    stackViewFooter.alignment = .center
    stackViewFooter.translatesAutoresizingMaskIntoConstraints = false
    cameraPreviewView.addSubview(stackViewFooter)
    
    galleryButton.translatesAutoresizingMaskIntoConstraints = false
    galleryButton.layer.borderWidth = 2
    galleryButton.layer.borderColor = CGColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    galleryButton.layer.cornerRadius = 5
    galleryButton.clipsToBounds = true
    galleryButton.addTarget(self, action: #selector(galleryButtonTapped), for: .touchUpInside)
    
    let leftView = UIView()
    leftView.addSubview(galleryButton)
    leftView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(leftView)
    
    // Capture Button
    let activeButtonImage = UIImage(named: "capture-button")
    let inactiveButtonImage = UIImage(named: "capture-button-2")
    
    let captureButton = UIButton()
    captureButton.setImage(activeButtonImage, for: .normal)
    captureButton.setImage(inactiveButtonImage, for: .highlighted)
    captureButton.translatesAutoresizingMaskIntoConstraints = false
    captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
    
    let centerView = UIView()
    centerView.addSubview(captureButton)
    centerView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(centerView)
    
    let rotateImage = UIImageView(image: UIImage(named: "rotate"))
    rotateImage.contentMode = .scaleAspectFit
    rotateImage.frame = CGRect(x: .zero, y: .zero, width: 30, height: 30)
    rotateButton.addSubview(rotateImage)
    rotateButton.isScaleAnimation = true
    rotateButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    rotateButton.translatesAutoresizingMaskIntoConstraints = false
    
    let rightView = UIView()
    rightView.addSubview(rotateButton)
    rightView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(rightView)
    
    // Auto Constraint for StackView
    NSLayoutConstraint.activate([
      leftView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      centerView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      rightView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      
      galleryButton.heightAnchor.constraint(equalToConstant: 50),
      galleryButton.widthAnchor.constraint(equalToConstant: 50),
      galleryButton.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
      galleryButton.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
      
      captureButton.heightAnchor.constraint(equalToConstant: 75),
      captureButton.widthAnchor.constraint(equalToConstant: 75),
      captureButton.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
      captureButton.centerYAnchor.constraint(equalTo: centerView.centerYAnchor),
      
      rotateButton.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
      rotateButton.centerYAnchor.constraint(equalTo: rightView.centerYAnchor)
    ])
    
    NSLayoutConstraint.activate([
      stackViewFooter.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor),
      stackViewFooter.trailingAnchor.constraint(equalTo: cameraPreviewView.trailingAnchor),
      stackViewFooter.bottomAnchor.constraint(equalTo: cameraPreviewView.bottomAnchor, constant: -20),
      stackViewFooter.heightAnchor.constraint(equalToConstant: 80),
    ])
  }
  
  func setupHeaderButtons() {
    flashButton.setImage(UIImage(systemName: "flashlight.off.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal), for: .normal)
    flashButton.translatesAutoresizingMaskIntoConstraints = false
    flashButton.addTarget(self, action: #selector(flashButtonPressed), for: .touchUpInside)
    cameraPreviewView.addSubview(flashButton)
    
    closeButton.setImage(UIImage(named: "close")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    cameraPreviewView.addSubview(closeButton)
    
    NSLayoutConstraint.activate([
      flashButton.topAnchor.constraint(equalTo: cameraPreviewView.topAnchor, constant: 20),
      flashButton.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor, constant: 20),
      flashButton.heightAnchor.constraint(equalToConstant: 30),
      flashButton.widthAnchor.constraint(equalToConstant: 30),
      
      closeButton.topAnchor.constraint(equalTo: cameraPreviewView.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: cameraPreviewView.trailingAnchor, constant: -20),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.widthAnchor.constraint(equalToConstant: 30),
    ])
  }
  
  private func getLastestImageFromGallery() {
    switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
    case .authorized:
      let allPhotoOptions = PHFetchOptions()
      allPhotoOptions.fetchLimit = 1
      allPhotoOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
      let allPhotos = PHAsset.fetchAssets(with: .image, options: allPhotoOptions)
      guard let firstImage = allPhotos.lastObject else {
        print("first image not valid")
        return
      }
      let requestImageOptions = PHImageRequestOptions()
      requestImageOptions.isSynchronous = false
      requestImageOptions.deliveryMode = .opportunistic
      
      let thumbnailSize = CGSize(width: 100, height: 100)
      
      let imageManager = PHImageManager.default()
      imageManager.requestImage(for: firstImage, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil) {image, _ in
        DispatchQueue.main.async {
          self.galleryButton.setImage(image, for: .normal)
        }
      }
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
        print(status)
      }
    case .denied, .restricted:
      print("")
    case .limited:
      print("")
    @unknown default:
      print("")
    }
  }
  
  @objc func flashButtonPressed() {
    flashButton.isSelected = !flashButton.isSelected
    rotateButton.rotate()
  }
  
  @objc func galleryButtonTapped() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      present(imagePickerVC, animated: true)
    }
  }
  
  @objc func closeButtonTapped() {}
  
  @objc func captureButtonTapped() {}
  
  @objc func doneButtonTapped() {}
}

extension CameraView: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    print("select image => ",info)
    dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
