//
//  SetupStyleQuizeVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class SetupStyleQuizeVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnStart: UIButton!
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


        self.lblTitle.text = NSLocalizedString("setupStyleQuizeTitle", comment: "")
        self.lblDetail.text = NSLocalizedString("setupStyleQuizeDetail", comment: "")
        self.btnStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        self.btnSkip.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("skip", comment: ""), attributes: skipButtonAttribute) , for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
        
    @IBAction func btnStartClicked(_ sender: Any) {
        
    }

    @IBAction func btnSkipClicked(_ sender: Any) {
        let controller = PushHomeControllerView.sharedInstance.HomeVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension SetupStyleQuizeVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
