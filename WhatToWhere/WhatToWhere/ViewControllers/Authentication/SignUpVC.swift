//
//  SignUpVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices
import SwiftGifOrigin

class SignUpVC: UIViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var lblErrorFullName: UILabel!
    @IBOutlet weak var lblErrorEmailAddress: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    @IBOutlet weak var lblErrorConfirmPassword: UILabel!
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewEmailAddress: UIView!
    @IBOutlet weak var viewFullName: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!

    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnContinueWithGoogle: UIButton!
    @IBOutlet weak var btnContinueWithFacebook: UIButton!
    @IBOutlet weak var btnContinueWithApple: UIButton!
    @IBOutlet weak var lblAlreadyHaveAccount: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var lblagreetoTC: UILabel!
    @IBOutlet weak var lblWhatToWhere: UILabel!
    @IBOutlet weak var lblAnd: UILabel!
    @IBOutlet weak var btnTermsConditions: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    
    var isValidated : Bool = false

    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }

    func setupLayout() {
        let signinButtonAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Bold, size: 16) as Any,
            .foregroundColor: UIColor(named: "Black") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let termConditionButtonAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Regular, size: 11) as Any,
            .foregroundColor: UIColor(named: "DarkGreyColor") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let privacyPolicyButtonAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Regular, size: 11) as Any,
            .foregroundColor: UIColor(named: "DarkGreyColor") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        self.txtEmailAddress.overrideUserInterfaceStyle = .light
        self.txtFullName.overrideUserInterfaceStyle = .light
        self.txtPassword.overrideUserInterfaceStyle = .light
        self.txtConfirmPassword.overrideUserInterfaceStyle = .light
        self.txtEmailAddress.placeholder = NSLocalizedString("enterEmailAddress", comment: "")
        self.txtFullName.placeholder = NSLocalizedString("fullName", comment: "")
        self.txtConfirmPassword.placeholder = NSLocalizedString("confirmPassword", comment: "")
        self.txtPassword.placeholder = NSLocalizedString("password", comment: "")
        self.lblNavTitle.text = NSLocalizedString("signUp", comment: "")
        self.btnContinueWithGoogle.setTitle(NSLocalizedString("continueWithGoogle", comment: ""), for: .normal)
        self.btnContinueWithFacebook.setTitle(NSLocalizedString("continueWithFacebook", comment: ""), for: .normal)
        self.btnContinueWithApple.setTitle(NSLocalizedString("continueWithApple", comment: ""), for: .normal)
        self.lblAlreadyHaveAccount.text = NSLocalizedString("alreadyAMember", comment: "")
        self.lblOr.text = NSLocalizedString("or", comment: "")
        self.lblagreetoTC.text = NSLocalizedString("agreetoTC&PP", comment: "")
        self.lblWhatToWhere.text = NSLocalizedString("whatToWhere", comment: "")
        self.lblAnd.text = NSLocalizedString("and", comment: "")
        self.btnTermsConditions.setTitle(NSLocalizedString("continueWithApple", comment: ""), for: .normal)
        self.btnPrivacyPolicy.setTitle(NSLocalizedString("continueWithApple", comment: ""), for: .normal)
        self.btnTermsConditions.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("termsAndConditions", comment: ""), attributes: termConditionButtonAttribute) , for: .normal)
        self.btnPrivacyPolicy.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("privacyPolicy", comment: ""), attributes: privacyPolicyButtonAttribute) , for: .normal)
        self.btnSignIn.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("signIn", comment: ""), attributes: signinButtonAttribute) , for: .normal)
        self.btnSignUp.setTitle(NSLocalizedString("signUp", comment: ""), for: .normal)
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

    @IBAction func btnSignUpClicked(_ sender: Any) {
        self.validateFullName()
        self.validateEmailAddress()
        self.validatePassword()
        self.validateConfirmPassword()
        if isValidated {
            self.callSignUpAPI(userName: getNotNullString(self.txtFullName.text) ?? "", emailAddress: getNotNullString(self.txtEmailAddress.text) ?? "" , password: getNotNullString(self.txtPassword.text) ?? "", isEmailVerified: true, loginType: LoginType.NormalLogin, profilePicture: "")
        }
    }
    
    @IBAction func btnGmailClicked(_ sender: Any) {
        let signInConfig = GIDConfiguration.init(clientID: MediaAccountKey.Google_ClientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            self.callSignUpAPI(userName: getNotNullString(user.profile?.givenName) ?? "", emailAddress: getNotNullString(user.profile?.email) ?? "", password: getNotNullString(user.profile?.email) ?? "", isEmailVerified: true, loginType: LoginType.GmailLogin,profilePicture: getNotNullString(user.profile?.imageURL(withDimension: 320)) ?? "")
        }
    }
    
    @IBAction func btnSignInClicked(_ sender: Any) {
        let controller = PushAuthenticationControllerView.sharedInstance.SignInVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnFacebookClicked(_ sender: Any) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            loginManager.logOut()
            
        } else {
            loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }

                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                let requestedFields = "email, first_name, last_name,id,name,picture.type(large)"
                GraphRequest.init(graphPath: "me", parameters: ["fields":requestedFields]).start { (connection, graphresult, error) -> Void in
                    print(graphresult!)
                    self.callSignUpAPI(userName: getNotNullString((graphresult as? [String : Any])!["name"]) ?? "",
                                       emailAddress: getNotNullString((graphresult as? [String : Any])!["email"]) ?? "",
                                       password: getNotNullString((graphresult as? [String : Any])!["id"]) ?? "",
                                       isEmailVerified: true,
                                       loginType: LoginType.FacebookLogin,
                                       profilePicture: getNotNullString((((graphresult as? [String : Any])!["picture"] as? [String : Any])!["data"] as? [String : Any])!["url"]) ?? "")
                }
            }
        }
    }
    
    @IBAction func btnAppleClicked(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTermsConditionClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.TermsConditionVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnPrivacyPolicyClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.PrivacyPolicyVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SignUpVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.txtEmailAddress {
            self.validateEmailAddress()
        }
        
        if textField == self.txtPassword {
            self.validatePassword()
        }
        
        if textField == self.txtFullName {
            self.validateFullName()
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

extension SignUpVC : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            self.navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension SignUpVC {
    func validateFullName() {
        self.lblErrorFullName.text = getNotNullString(self.txtFullName.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : ""
        self.lblErrorFullName.isHidden = getNotNullString(self.txtFullName.text) == "" ? false : true
        self.viewFullName.layer.borderColor = getNotNullString(self.txtFullName.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtFullName.text) == "" ? false : true
    }
    
    func validateEmailAddress() {
        self.lblErrorEmailAddress.text = getNotNullString(self.txtEmailAddress.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? "" : NSLocalizedString("emailInvalid", comment: ""))
        self.lblErrorEmailAddress.isHidden = getNotNullString(self.txtEmailAddress.text) == "" ? false : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? true : false)
        self.viewEmailAddress.layer.borderColor = getNotNullString(self.txtEmailAddress.text) == "" ? UIColor(named: "RedColor")?.cgColor : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? UIColor(named: "Black")?.cgColor : UIColor(named: "RedColor")?.cgColor)
        self.isValidated = getNotNullString(self.txtEmailAddress.text) == "" ? false : (getNotNullString(self.txtEmailAddress.text)?.isValidEmail() ?? false ? true : false)
    }
    
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

extension SignUpVC : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
                 switch credentialState {
                    case .authorized:
                        // The Apple ID credential is valid.
                     self.callSignUpAPI(userName: "\(getNotNullString(appleIDCredential.fullName?.givenName) ?? "") \(getNotNullString(appleIDCredential.fullName?.familyName) ?? "")",
                                        emailAddress: getNotNullString(appleIDCredential.email) ?? "",
                                        password: getNotNullString(appleIDCredential.user) ?? "",
                                        isEmailVerified: true,
                                        loginType: LoginType.AppleLogin,
                                        profilePicture:  "")
                        break
                    case .revoked:
                     NSUtils.sharedInstance.showAlert(title: "", message: "appleCredentialRevoked", controller: self)
                        // The Apple ID credential is revoked.
                        break
                 case .notFound:
                        // No credential was found, so show the sign-in UI.
                     NSUtils.sharedInstance.showAlert(title: "", message: "appleNoCredentilFound", controller: self)
                     break
                    default:
                        break
                 }
            }

        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

}

//MARK: - API Call
extension SignUpVC {
    
    func callSignUpAPI(userName : String, emailAddress : String, password : String, isEmailVerified : Bool , loginType : String, profilePicture : String ) {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executePostAPICallWithMethod(apiName: APIClient.API.signup, params: APIClient.Parameters.signup(email_id: emailAddress, userName: userName, password: password, loginType: loginType, firebaseToken: NSUtils.sharedInstance.device_token, deviceType: "iphone",isEmailVefied: isEmailVerified ,profilePicture: profilePicture).getParams()) { data, responseCode, error in
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
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data as Any)
                        if let json = String(data: jsonData, encoding: .utf8) {
                            guard let properData = json.data(using: .utf8, allowLossyConversion: true) else { return }
                            let loginData = try? JSONDecoder().decode(LoginResponseModel.self, from: properData) as LoginResponseModel

                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.UserId, valueParameter: getNotNullString(loginData?.data?.userID) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.UserName, valueParameter: getNotNullString(loginData?.data?.userName) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Description, valueParameter: getNotNullString(loginData?.data?.userBio) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.ProfileImage, valueParameter: getNotNullString(loginData?.data?.profileImage) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.FollowerCount, valueParameter: getNotNullString(loginData?.data?.followerCount) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.FollowingCount, valueParameter: getNotNullString(loginData?.data?.followingCount) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.LoginType, valueParameter: getNotNullString(loginData?.data?.loginType) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.LoginFirst, valueParameter: getNotNullString(loginData?.data?.loginFirst) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Gender, valueParameter: getNotNullString(loginData?.data?.gender) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Mobile, valueParameter: getNotNullString(loginData?.data?.mobile) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.DOB, valueParameter: getNotNullString(loginData?.data?.dob) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Email, valueParameter: getNotNullString(loginData?.data?.email) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Pronouns, valueParameter: getNotNullString(loginData?.data?.pronouns) ?? "")
                            NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.AccessToken, valueParameter: getNotNullString(loginData?.data?.accessToken) ?? "")

                            if loginData?.data?.loginFirst == true {
                                NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.InitialVC, valueParameter: "1")
                                let controller = PushHomeControllerView.sharedInstance.SetupProfileVC()
                                self.navigationController?.pushViewController(controller, animated: true)
                            } else {
                                NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.InitialVC, valueParameter: "2")
                                let controller = PushHomeControllerView.sharedInstance.HomeVC()
                                self.navigationController?.pushViewController(controller, animated: true)
                            }
                        }
                    } catch {
                        NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("SomethingWentWrongWithParsingJson", comment: "") , controller: self)
                    }
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
}
