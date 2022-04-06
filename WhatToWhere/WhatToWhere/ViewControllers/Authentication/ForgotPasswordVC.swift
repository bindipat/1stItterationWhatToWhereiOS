//
//  ForgotPasswordVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblFirstInfoMessage: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblErrorEmailAddress: UILabel!
    @IBOutlet weak var viewEmailAddress: UIView!

    var isValidated : Bool = false

    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.txtEmailAddress.overrideUserInterfaceStyle = .light
        self.lblNavTitle.text = NSLocalizedString("forgotPassword", comment: "")
        self.lblFirstInfoMessage.text = NSLocalizedString("forgotPasswordInformation", comment: "")
        self.txtEmailAddress.placeholder = NSLocalizedString("enterEmailAddress", comment: "")
        self.btnSubmit.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
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
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        self.validateEmailAddress()
        if isValidated {
            self.callForgotPasswordCodeAPI()
        }
    }
}

extension ForgotPasswordVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateEmailAddress()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension ForgotPasswordVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension ForgotPasswordVC {
    func validateEmailAddress() {
        self.lblErrorEmailAddress.text = getNotNullString(self.txtEmailAddress.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? "" : NSLocalizedString("emailInvalid", comment: ""))
        self.lblErrorEmailAddress.isHidden = getNotNullString(self.txtEmailAddress.text) == "" ? false : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? true : false)
        self.viewEmailAddress.layer.borderColor = getNotNullString(self.txtEmailAddress.text) == "" ? UIColor(named: "RedColor")?.cgColor : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? UIColor(named: "Black")?.cgColor : UIColor(named: "RedColor")?.cgColor)
        self.isValidated = getNotNullString(self.txtEmailAddress.text) == "" ? false : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? true : false)
    }
}

//MARK: - API Call
extension ForgotPasswordVC {
    func callForgotPasswordCodeAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executeGetAPICallWithMethod(apiName: "\(APIClient.API.verificationCode)?email=\(getNotNullString(self.txtEmailAddress.text) ?? "")") { data, responseCode, error in
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
                    let controller = PushAuthenticationControllerView.sharedInstance.VerificationVC()
                    controller.strVerificationCode = getNotNullString((data?["data"] as? [String : Any])?["emailcode"] ?? "") ?? ""
                    controller.strEmailAddress = getNotNullString(self.txtEmailAddress.text) ?? ""
                    controller.strUserId = getNotNullString((data?["data"] as? [String : Any])?["UserId"] ?? "") ?? ""
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
}
