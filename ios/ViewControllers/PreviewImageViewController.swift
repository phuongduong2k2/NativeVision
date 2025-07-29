//
//  PreviewCapturedImageViewController.swift
//  LinkingApp
//
//  Created by Duong Phuong on 25/7/25.
//

import UIKit

protocol PreviewImageViewControllerDelegate: AnyObject {
  func done(_ view: PreviewImageViewController)
  func selectedImage(_ view: PreviewImageViewController, image: UIImage)
}

class PreviewImageViewController: UIViewController {
  
  var image: UIImage!
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
    imageView.image = image
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
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(afterSavePicture), nil)
    delegate?.selectedImage(self, image: image)
  }
  
  @objc private func afterSavePicture(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    cancelPreview()
  }
  
  @objc private func cancelPreview() {
    dismiss(animated: true)
  }
}
