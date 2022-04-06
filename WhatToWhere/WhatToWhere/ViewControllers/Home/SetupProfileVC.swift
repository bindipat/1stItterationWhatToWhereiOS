//
//  SetupProfileVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class SetupProfileVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        let skipButtonAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Bold, size: 16) as Any,
            .foregroundColor: UIColor(named: "Black") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
            
        ] // .double.rawValue, .thick.rawValue


        self.lblTitle.text = NSLocalizedString("setupProfileTitle", comment: "")
        self.lblDetail.text = NSLocalizedString("setupProfileDetail", comment: "")
        self.btnEditProfile.setTitle(NSLocalizedString("editProfile", comment: ""), for: .normal)
        self.btnSkip.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("skip", comment: ""), attributes: skipButtonAttribute) , for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
        
    @IBAction func btnEditProfileClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.EditProfileVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnSkipClicked(_ sender: Any) {
        let controller = PushHomeControllerView.sharedInstance.SetupStyleQuizeVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension SetupProfileVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
