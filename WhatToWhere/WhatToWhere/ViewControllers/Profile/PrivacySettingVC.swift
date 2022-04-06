//
//  PrivacySettingVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class PrivacySettingVC: UIViewController {
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblProfileTitle: UILabel!
    @IBOutlet weak var lblProfileDetailInfo: UILabel!
    @IBOutlet weak var lblNotificationTitle: UILabel!
    @IBOutlet weak var lblNotificationDetailInfo: UILabel!

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
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdateProfileSettingClicked(_ sender: Any) {

    }

    @IBAction func btnUpdateNotificationSettingClicked(_ sender: Any) {

    }

}

extension PrivacySettingVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension PrivacySettingVC {
    func callUpdatePrivacySettingAPI() {
        
    }
}
