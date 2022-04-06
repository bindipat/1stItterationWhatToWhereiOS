//
//  PreviewView.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 03/04/22.
//

import UIKit
import AVFoundation

final class PreviewView: UIView {
  
  // 1
  override class var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }

  // 2
  var videoPreviewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }
  
  // 3
  var session: AVCaptureSession? {
    get {
      return videoPreviewLayer.session
    }
    set {
      videoPreviewLayer.session = newValue
    }
  }
}
