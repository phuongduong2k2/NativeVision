//
//  PreviewCapturedImageViewController.swift
//  LinkingApp
//
//  Created by Duong Phuong on 25/7/25.
//

import UIKit

protocol PreviewImageViewControllerDelegate: AnyObject {
  func done(_ view: PreviewImageViewController)
  func selectedImage(_ view: PreviewImageViewController,_ imageUri: String)
}

class PreviewImageViewController: UIViewController {
  
  var imageData: Data!
  weak var delegate: PreviewImageViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setupView()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    delegate?.done(self)
  }
  
  private func setupView() {
    let imageView = UIImageView()
    imageView.image = UIImage(data: imageData)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)
    
    let useButton = UIButton(type: .system)
    useButton.setTitle("Use", for: .normal)
    useButton.translatesAutoresizingMaskIntoConstraints = false
    useButton.addTarget(self, action: #selector(usePicture), for: .touchUpInside)
    view.addSubview(useButton)
    
    let cancelButton = UIButton(type: .system)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.tintColor = .red
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.addTarget(self, action: #selector(cancelPreview), for: .touchUpInside)
    view.addSubview(cancelButton)
    
    let footerView = UIView()
    footerView.addSubview(useButton)
    footerView.addSubview(cancelButton)
    footerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(footerView)
    
    NSLayoutConstraint.activate([
      footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      footerView.heightAnchor.constraint(equalToConstant: 80),
      footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      useButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
      useButton.heightAnchor.constraint(equalTo: footerView.heightAnchor),
      
      cancelButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
      cancelButton.heightAnchor.constraint(equalTo: footerView.heightAnchor)
    ])
    
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.bottomAnchor.constraint(lessThanOrEqualTo: footerView.topAnchor)
    ])
  }
  
  @objc private func usePicture() {
    let fileManager = FileManager.default
    let tempDir = fileManager.temporaryDirectory
    let fileName = UUID().uuidString + ".jpeg"
    let path = tempDir.appendingPathComponent(fileName, conformingTo: .image)
    
    do {
      try imageData.write(to: path)
      dismiss(animated: true)
      delegate?.selectedImage(self, path.absoluteString)
    } catch {
      print("Can not save image to temporary directory!")
    }
  }
  
  @objc private func afterSavePicture(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    cancelPreview()
  }
  
  @objc private func cancelPreview() {
    dismiss(animated: true)
  }
}
