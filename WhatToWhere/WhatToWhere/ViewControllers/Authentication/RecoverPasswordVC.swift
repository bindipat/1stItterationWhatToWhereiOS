//
//  RecoverPasswordVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 17/03/22.
//

import Foundation
import UIKit

class RecoverPasswordVC: UIViewController {
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    @IBOutlet weak var lblErrorPassword: UILabel!
    @IBOutlet weak var lblErrorConfirmPassword: UILabel!

    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!

    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblFirstInfoMessage: UILabel!
    @IBOutlet weak var btnResetPassword: UIButton!

    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    var strUserId = String()
    var isValidated : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.txtPassword.overrideUserInterfaceStyle = .light
        self.txtConfirmPassword.overrideUserInterfaceStyle = .light
        self.lblFirstInfoMessage.text = NSLocalizedString("pleaseSetNewPassword", comment: "")
        self.lblNavTitle.text = NSLocalizedString("resetPassword", comment: "")
        self.btnResetPassword.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
        self.txtConfirmPassword.placeholder = NSLocalizedString("confirmPassword", comment: "")
        self.txtPassword.placeholder = NSLocalizedString("password", comment: "")

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
        
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        self.validatePassword()
        self.validateConfirmPassword()
        if isValidated {
            self.callRecoverPasswordAPI()
        }
    }
}

extension RecoverPasswordVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtPassword {
            self.validatePassword()
        }
                
        if textField == self.txtConfirmPassword {
            self.validateConfirmPassword()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension RecoverPasswordVC {
    
    func validatePassword() {
        self.lblErrorPassword.text = getNotNullString(self.txtPassword.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtPassword.text)?.length ?? 0 < 6 ? NSLocalizedString("passwordMustBe6Char", comment: "") : "")
        self.lblErrorPassword.isHidden = getNotNullString(self.txtPassword.text) == "" ? false : true
        self.viewPassword.layer.borderColor = getNotNullString(self.txtPassword.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtPassword.text) == "" ? false : true
    }

    func validateConfirmPassword() {
        self.lblErrorConfirmPassword.text = getNotNullString(self.txtConfirmPassword.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? "" : NSLocalizedString("passwordMustMatch", comment: ""))
        self.lblErrorConfirmPassword.isHidden = getNotNullString(self.txtConfirmPassword.text) == "" ? false : (getNotNullString(self.txtPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? true : false)
        self.viewConfirmPassword.layer.borderColor = getNotNullString(self.txtConfirmPassword.text) == "" ? UIColor(named: "RedColor")?.cgColor : (getNotNullString(self.txtPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? UIColor(named: "Black")?.cgColor : UIColor(named: "RedColor")?.cgColor)
        self.isValidated = getNotNullString(self.txtConfirmPassword.text) == "" ? false : (getNotNullString(self.txtPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? true : false)

    }
}

extension RecoverPasswordVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension RecoverPasswordVC {
    func callRecoverPasswordAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executePostAPICallWithMethod(apiName: APIClient.API.forgotPassword, params: APIClient.Parameters.forgotPassword(user_id: self.strUserId, password: getNotNullString(self.txtPassword.text) ?? "").getParams()) { data, responseCode, error in
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
                    let alert = UIAlertController(title: "", message: NSLocalizedString("passwordSetSuccessfully", comment: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("Okay", comment: ""), style: .default) { (action) in
                        print("\(String(describing: action.title))")
                        for viewController : UIViewController in (self.navigationController?.viewControllers)! {
                            if viewController is SignInVC {
                                let controller : SignInVC? = (viewController as? SignInVC)
                                self.navigationController?.popToViewController(controller!, animated: true)
                                return
                            }
                        }
                        
                        let controller = PushAuthenticationControllerView.sharedInstance.SignInVC()
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    alert.addAction(okAction)
                    alert.preferredAction = okAction
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })

                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
}
