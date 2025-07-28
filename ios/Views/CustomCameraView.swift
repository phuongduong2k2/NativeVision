//
//  CustomCameraView.swift
//  NativeVision
//
//  Created by Duong Phuong on 28/7/25.
//

import UIKit

class CustomCameraView: UIViewController {

  let cameraPreviewView = UIView()
  let flashButton = UIButton()
  
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
  }

  func setupFooterButtons() {
    
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
    
    let doneButton = UIButton(type: .system)
    doneButton.setTitle("Done", for: .normal)
    doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    doneButton.translatesAutoresizingMaskIntoConstraints = false
    
    let rightView = UIView()
    rightView.addSubview(doneButton)
    rightView.translatesAutoresizingMaskIntoConstraints = false
    stackViewFooter.addArrangedSubview(rightView)
    
    // Auto Constraint for StackView
    NSLayoutConstraint.activate([
      leftView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      centerView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      rightView.heightAnchor.constraint(equalTo: stackViewFooter.heightAnchor),
      
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
    
    NSLayoutConstraint.activate([
      stackViewFooter.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor),
      stackViewFooter.trailingAnchor.constraint(equalTo: cameraPreviewView.trailingAnchor),
      stackViewFooter.bottomAnchor.constraint(equalTo: cameraPreviewView.bottomAnchor, constant: -20),
      stackViewFooter.heightAnchor.constraint(equalToConstant: 80),
    ])
  }
  
  func setupHeaderButtons() {
    flashButton.setImage(UIImage(systemName: "flashlight.off.fill")?.withTintColor(.systemYellow).withRenderingMode(.alwaysOriginal), for: .selected)
    flashButton.setImage(UIImage(systemName: "flashlight.off.fill")?.withTintColor(.systemGray).withRenderingMode(.alwaysOriginal), for: .normal)
    flashButton.translatesAutoresizingMaskIntoConstraints = false
    flashButton.addTarget(self, action: #selector(flashButtonPressed), for: .touchUpInside)
    cameraPreviewView.addSubview(flashButton)
    
    NSLayoutConstraint.activate([
      flashButton.topAnchor.constraint(equalTo: cameraPreviewView.topAnchor, constant: 20),
      flashButton.leadingAnchor.constraint(equalTo: cameraPreviewView.leadingAnchor, constant: 20),
      flashButton.heightAnchor.constraint(equalToConstant: 30),
      flashButton.widthAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  @objc func flashButtonPressed() {
    flashButton.isSelected = !flashButton.isSelected
  }
  
  @objc func captureButtonTapped() {}
  
  @objc func doneButtonTapped() {}
}
