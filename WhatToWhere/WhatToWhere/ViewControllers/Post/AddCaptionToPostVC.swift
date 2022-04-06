//
//  AddCaptionToPostVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 15/03/22.
//

import Foundation
import UIKit

class AddCaptionToPostVC: UIViewController {
    @IBOutlet weak var imgVideoPreview: UIImageView!
    
    var videoImage : UIImage = UIImage()
    var videoEditImage : UIImage = UIImage()
    
    var app = AppDelegate()
    
    var videoSelectURL: URL!
    var videoEditURL: URL!
    
    @IBOutlet var viewPrivacy: UIView!
    
    @IBOutlet var btnPublic: UIButton!
    @IBOutlet var btnPrivate: UIButton!
    @IBOutlet var btnWhoCanSee: UIButton!
    var strType = String()
    
    @IBOutlet var btnSaveVideo: UIButton!
    @IBOutlet var lblSaveVideo: UILabel!
    var strSelectType = String()
    var isVideoEdit = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {

    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
        
    
}

extension AddCaptionToPostVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
