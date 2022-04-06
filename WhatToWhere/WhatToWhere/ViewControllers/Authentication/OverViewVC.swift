//
//  OverViewVC.swift
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

class OverViewVC: UIViewController {
    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSignUpClicked(_ sender: Any) {
        let controller = PushAuthenticationControllerView.sharedInstance.SignUpVC()
        self.navigationController?.pushViewController(controller, animated: true)
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
    
}

extension OverViewVC : ASAuthorizationControllerDelegate {
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
extension OverViewVC {
    
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

