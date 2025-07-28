//
//  PreviewCapturedImageViewController.swift
//  LinkingApp
//
//  Created by Duong Phuong on 25/7/25.
//

import UIKit

protocol PreviewCapturedImageViewControllerDelegate: AnyObject {
  func done(_ view: PreviewCapturedImageViewController)
}

class PreviewCapturedImageViewController: UIViewController {
  
  var image: UIImage!
  weak var delegate: PreviewCapturedImageViewControllerDelegate?
  
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
    
    let useImageButton = UIButton(type: .system)
    useImageButton.setTitle("Use this picture", for: .normal)
    useImageButton.translatesAutoresizingMaskIntoConstraints = false
    useImageButton.addTarget(self, action: #selector(usePicture), for: .touchUpInside)
    view.addSubview(useImageButton)
    
    let cancelButton = UIButton(type: .system)
    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.tintColor = .red
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    cancelButton.addTarget(self, action: #selector(cancelPreview), for: .touchUpInside)
    view.addSubview(cancelButton)
    
    NSLayoutConstraint.activate([
      imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      useImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      useImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
      
      cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
    ])
  }
  
  @objc private func usePicture() {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(afterSavePicture), nil)
  }
  
  @objc private func afterSavePicture(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    cancelPreview()
  }
  
  @objc private func cancelPreview() {
    dismiss(animated: true)
  }
}
