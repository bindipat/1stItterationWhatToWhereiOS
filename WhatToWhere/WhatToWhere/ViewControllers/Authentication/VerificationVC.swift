//
//  VerificationVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit
import DPOTPView

class VerificationVC: UIViewController {
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblFirstInfoMessage: UILabel!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    
    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    @IBOutlet weak var pinCodeView: DPOTPView!
    var strVerificationCode = String()
    var strEmailAddress = String()
    var strUserId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        let resendButtonAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Bold, size: 16) as Any,
            .foregroundColor: UIColor(named: "Black") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
            
        ] // .double.rawValue, .thick.rawValue

        pinCodeView.dpOTPViewDelegate = self
        self.lblNavTitle.text = NSLocalizedString("verificationCode", comment: "")
        self.lblFirstInfoMessage.text = NSLocalizedString("forgotPasswordInformation", comment: "")
        self.btnVerify.setTitle(NSLocalizedString("verify", comment: ""), for: .normal)
        self.btnResend.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("resend", comment: ""), attributes: resendButtonAttribute) , for: .normal)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyClicked(_ sender: Any) {
        if self.pinCodeView.text == self.strVerificationCode {
            let controller = PushAuthenticationControllerView.sharedInstance.RecoverPasswordVC()
            controller.strUserId = self.strUserId
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            if  self.pinCodeView.text?.count == 6 {
                if self.pinCodeView.text != self.strVerificationCode {
                    NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("wrongCode", comment: "") , controller: self)
                }
            } else {
                NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("enter6DigitCode", comment: "") , controller: self)
            }
        }
    }

    @IBAction func btnResendClicked(_ sender: Any) {
        self.callResendCodeAPI()
    }

}

extension VerificationVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension VerificationVC : DPOTPViewDelegate {
   func dpOTPViewAddText(_ text: String, at position: Int) {

   }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {

    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {

    }
    
    func dpOTPViewBecomeFirstResponder() {
        
    }
    
    func dpOTPViewResignFirstResponder() {
        
    }
}

//MARK: - API Call

extension VerificationVC {
    
    func callResendCodeAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executeGetAPICallWithMethod(apiName: "\(APIClient.API.verificationCode)?email=\(getNotNullString(self.strEmailAddress) ?? "")") { data, responseCode, error in
            self.viewLoading.isHidden = true
            self.imgLoading.isHidden = true
            if((error) != nil) {
                if((data) != nil){
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: error!.localizedDescription, controller: self)
                }
            } else {
                if responseCode == 200 {
                    NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("codeResend", comment: ""), controller: self)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
}
