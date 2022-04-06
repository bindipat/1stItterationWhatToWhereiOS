//
//  ReportAnIssueVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class ReportAnIssueVC: UIViewController {
    @IBOutlet weak var txtContactDesc: UITextView!
    @IBOutlet weak var lblSelectReason: UILabel!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text = NSLocalizedString("reportAnIssue", comment: "")
        self.lblSelectReason.text = NSLocalizedString("select", comment: "")
        self.lblInformation.text = NSLocalizedString("contactUsMainInfo", comment: "")
        self.lblEmailAddress.text = NSLocalizedString("wwwWhatToWhereCom", comment: "")
        self.txtContactDesc.text = NSLocalizedString("description", comment: "")
        self.btnSubmit.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension ReportAnIssueVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}


//MARK: - API Call
extension ReportAnIssueVC {
    func callReportIssueAPI() {
        
    }
}
