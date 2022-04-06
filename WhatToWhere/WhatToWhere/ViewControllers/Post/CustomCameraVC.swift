//
//  CustomCameraVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 15/03/22.
//

import Foundation
import AVFoundation
import UIKit

class CustomCameraVC: UIViewController {
    @IBOutlet weak var previewView: PreviewView! {
      didSet {
          previewView.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewView.clipsToBounds = true
      }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
      didSet {
        imageView.clipsToBounds = true
      }
    }
    
    fileprivate let session: AVCaptureSession = {
      let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
      return session
    }()
    
    fileprivate let output = AVCapturePhotoOutput()
  }

// MARK: - View Controller Life Cycle
extension CustomCameraVC {
    override func viewDidLoad() {
      super.viewDidLoad()
      setupCamera()
    }

    private func setupCamera() {
        let backCamera = AVCaptureDevice.default(for: .video)!
        guard let input = try? AVCaptureDeviceInput(device: backCamera) else { fatalError("back camera not functional.") }
      session.addInput(input)
      session.addOutput(output)
      previewView.session = session
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      session.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      session.stopRunning()
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CustomCameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
      guard let sampleBuffer = photoSampleBuffer else { fatalError("sample buffer was nil") }
      guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: nil) else { fatalError("could not get image data from sample buffer.") }
      imageView.image = UIImage(data: imageData)
    }
}

// MARK: - @IBActions
private extension CustomCameraVC {
    @IBAction func capturePhoto() {
      let captureSettings = AVCapturePhotoSettings()
      captureSettings.isAutoStillImageStabilizationEnabled = true
      output.capturePhoto(with: captureSettings, delegate: self)
    }
}
