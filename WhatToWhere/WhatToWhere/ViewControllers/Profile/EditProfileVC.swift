//
//  EditProfileVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/03/22.
//

import Foundation
import UIKit
import RESegmentedControl
import CryptoKit
import ActionSheetPicker_3_0

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblChooseYourPronouns: UILabel!
    
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var btnEditProfilePicture: UIButton!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var btnDeleteAccount: UIButton!

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtFacebookHandle: UITextField!
    @IBOutlet weak var txtInstagramHandle: UITextField!
    @IBOutlet weak var txtTikTockHandle: UITextField!
    @IBOutlet weak var txtYoutubeHandle: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    @IBOutlet weak var txtBio: UITextView!
    
    @IBOutlet weak var lblErrorFullName: UILabel!
    @IBOutlet weak var lblErrorPhoneNumber: UILabel!
    @IBOutlet weak var lblErrorBio: UILabel!
    @IBOutlet weak var lblErrorOldPassword: UILabel!
    @IBOutlet weak var lblErrorNewPassword: UILabel!
    @IBOutlet weak var lblErrorConfirmPassword: UILabel!
    @IBOutlet weak var lblAddGroupInfo: UILabel!
    @IBOutlet weak var viewFullName: UIView!
    @IBOutlet weak var viewOldPassword: UIView!
    @IBOutlet weak var viewNewPassword: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!

    @IBOutlet weak var viewBio: UIView!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var changePasswordScrollView: UIScrollView!

    let normalEditProfileSegmentItem = [NSLocalizedString("profileInfo", comment: ""), NSLocalizedString("changePassword", comment: "")]
    let socialEditProfileSegmentItem = [NSLocalizedString("profileInfo", comment: "")]
    let pronounsSegmentItem = [NSLocalizedString("she", comment: ""), NSLocalizedString("he", comment: ""), NSLocalizedString("they", comment: "")]
    
    @IBOutlet weak var profileChangePassworkSegment: RESegmentedControl! {
        didSet {
            var segmentItems: [SegmentModel] {
                return NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.LoginType) == LoginType.NormalLogin ? normalEditProfileSegmentItem.map({ SegmentModel(title: $0) }) : socialEditProfileSegmentItem.map({ SegmentModel(title: $0) })
            }
            
            var preset = MaterialPreset(backgroundColor: .clear, tintColor: UIColor(named: "Black")!)

            preset.segmentItemAxis = .vertical
            preset.textColor = UIColor(named: "Black")!
            preset.selectedTextColor = UIColor(named: "Black")!
            preset.textFont = UIFont(name: FontName.DMSans_Regular, size: 16)!
            preset.selectedTextFont = UIFont(name: FontName.DMSans_Medium, size: 16)!

            profileChangePassworkSegment.configure(segmentItems: segmentItems, preset: preset)
        }
    }

    @IBOutlet weak var pronounsSegment: RESegmentedControl! {
        didSet {
            var segmentItems: [SegmentModel] {
                return pronounsSegmentItem.map({ SegmentModel(title: $0) })
            }
            
            var preset = iOS7Preset(tintColor: UIColor(named: "Black")!)

            preset.textColor = UIColor(named: "Black")!
            preset.selectedTextColor = UIColor(named: "White")!
            preset.textFont = UIFont(name: FontName.DMSans_Regular, size: 16)!
            preset.selectedTextFont = UIFont(name: FontName.DMSans_Medium, size: 16)!

            pronounsSegment.configure(segmentItems: segmentItems, preset: preset)
        }
    }

    var isValidated : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        let deleteAccountAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: FontName.DMSans_Medium, size: 16) as Any,
            .foregroundColor: UIColor(named: "Black") as Any,
            .underlineStyle: NSUnderlineStyle.single.rawValue
            
        ] // .double.rawValue, .thick.rawValue

        
        self.lblNavTitle.text = NSLocalizedString("editProfile", comment: "")
                    
        self.profileScrollView.isHidden = self.profileChangePassworkSegment.selectedSegmentIndex == 0 ? false : true
        self.changePasswordScrollView.isHidden = self.profileChangePassworkSegment.selectedSegmentIndex == 1 ? false : true
        
        self.txtFullName.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserName)
        self.txtBio.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.Description)
        self.txtEmailAddress.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.Email)
        self.txtPhoneNumber.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.Mobile)
        self.lblGender.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.Gender)
        
        self.txtFullName.overrideUserInterfaceStyle = .light
        self.txtEmailAddress.overrideUserInterfaceStyle = .light
        self.txtBio.overrideUserInterfaceStyle = .light
        self.txtConfirmPassword.overrideUserInterfaceStyle = .light
        self.txtNewPassword.overrideUserInterfaceStyle = .light
        self.txtPhoneNumber.overrideUserInterfaceStyle = .light
        self.txtOldPassword.overrideUserInterfaceStyle = .light
        
        self.txtFullName.placeholder = NSLocalizedString("fullName", comment: "")
        self.txtBio.text = NSLocalizedString("descBio", comment: "")
        self.txtPhoneNumber.placeholder = NSLocalizedString("enterPhoneNumber", comment: "")
        self.lblGender.text = NSLocalizedString("selectGender", comment: "")
        self.lblDOB.text = NSLocalizedString("dob", comment: "")
        self.btnEditProfilePicture.setTitle(NSLocalizedString("changeProfilePicture", comment: ""), for: .normal)
        self.txtOldPassword.placeholder = NSLocalizedString("currentPassword", comment: "")
        self.txtNewPassword.placeholder = NSLocalizedString("newPassword", comment: "")
        self.txtConfirmPassword.placeholder = NSLocalizedString("confirmPassword", comment: "")
        self.lblChooseYourPronouns.text = NSLocalizedString("choosePronouns", comment: "")
        self.btnChangePassword.setTitle(NSLocalizedString("updatePassword", comment: ""), for: .normal)
        self.btnEditProfile.setTitle(NSLocalizedString("updateProfile", comment: ""), for: .normal)
        self.btnDeleteAccount.setAttributedTitle(NSAttributedString(string:  NSLocalizedString("deleteAccount", comment: ""), attributes: deleteAccountAttribute) , for: .normal)
        
        self.txtFacebookHandle.placeholder = NSLocalizedString("socialHandle", comment: "")
        self.txtInstagramHandle.placeholder = NSLocalizedString("socialHandle", comment: "")
        self.txtTikTockHandle.placeholder = NSLocalizedString("socialHandle", comment: "")
        self.txtYoutubeHandle.placeholder = NSLocalizedString("socialHandle", comment: "")
        
        let addGroupInfoAttributedString : NSMutableAttributedString = NSMutableAttributedString(string: NSLocalizedString("addGroupInfo", comment: ""))
        let pattern = NSLocalizedString("yourGroup", comment: "")
        let range : NSRange = NSMakeRange(0, NSLocalizedString("addGroupInfo", comment: "").length)
        var regex = NSRegularExpression()
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
            regex.enumerateMatches(in: NSLocalizedString("addGroupInfo", comment: "").lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) in
                let subRange = textCheckingResult?.range
                let attributes : [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: FontName.DMSans_Bold, size: 16) as Any,
                    .foregroundColor: UIColor(named: "Black") as Any
                ]
                addGroupInfoAttributedString.addAttributes(attributes, range: subRange!)
            }
        } catch {
            print(error.localizedDescription)
        }
        self.lblAddGroupInfo.attributedText = addGroupInfoAttributedString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func segmentedControlChangedValue(_ sender: RESegmentedControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            self.isValidated = false
            self.profileScrollView.isHidden = false
            self.changePasswordScrollView.isHidden = true
        } else {
            self.isValidated = false
            self.profileScrollView.isHidden = true
            self.changePasswordScrollView.isHidden = false
        }
    }

    @IBAction func pronounsSegmentedControlChangedValue(_ sender: RESegmentedControl) {
        print(sender.selectedSegmentIndex)
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditProfilePictureClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnSelectGenderClicked(_ sender: Any) {
        let genderItem = [NSLocalizedString("male", comment: ""), NSLocalizedString("female", comment: ""), NSLocalizedString("other", comment: "")]
        ActionSheetStringPicker.show(withTitle: NSLocalizedString("", comment: ""), rows: genderItem, initialSelection: genderItem.firstIndex(of: self.lblGender.text ?? "") ?? 0 , doneBlock: { picker, index, value in
            self.lblGender.text = value as? String
        }, cancel: { pickerCancelBlock in
            return
        }, origin: self.view)
    }

    @IBAction func btnSelectDOBClicked(_ sender: Any) {
        let selectedDate = self.lblDOB.text != NSLocalizedString("dob", comment: "") ? NSUtils.sharedInstance.convertStringToDate(strDate: NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.DOB) ?? "") : Date().dateByAddingYears(-18)
        let maximumDate = Date().dateByAddingYears(-18)
        let minimumDate = Date().dateByAddingYears(-80)
        
        ActionSheetDatePicker.show(withTitle: NSLocalizedString("", comment: ""), datePickerMode: .date, selectedDate: selectedDate, minimumDate: minimumDate, maximumDate: maximumDate, doneBlock: { picker, date, origin in
            self.lblDOB.text = (date as? Date)?.dateString("dd/MM/yyyy")
        }, cancel: { picker in
            return
        }, origin: self.view)
        
    }

    @IBAction func btnUpdateProfileClicked(_ sender: Any) {
        self.validateFullName()
        self.validateBio()
        self.validatePhoneNumber()
        if isValidated {
            self.callEditProfileAPI()
        }
    }

    @IBAction func btnChangePasswordClicked(_ sender: Any) {
        self.validateOldPassword()
        self.validateNewPassword()
        self.validateConfirmPassword()
        if isValidated {
            self.callChangePasswordAPI()
        }
    }
    
    @IBAction func btnAddGroupClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnDeleteAccountClicked(_ sender: Any) {
        
    }
    
}

//MARK: - Validate All Mandatory Fields 
extension EditProfileVC {
    func validateOldPassword() {
        self.lblErrorOldPassword.text = getNotNullString(self.txtOldPassword.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : ""
        self.lblErrorOldPassword.isHidden = getNotNullString(self.txtOldPassword.text) == "" ? false : true
        self.viewOldPassword.layer.borderColor = getNotNullString(self.txtOldPassword.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtOldPassword.text) == "" ? false : true
    }
    
    func validateNewPassword() {
        self.lblErrorNewPassword.text = getNotNullString(self.txtNewPassword.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtNewPassword.text)?.length ?? 0 < 6 ? NSLocalizedString("passwordMustBe6Char", comment: "") : "")
        self.lblErrorNewPassword.isHidden = getNotNullString(self.txtNewPassword.text) == "" ? false : true
        self.viewNewPassword.layer.borderColor = getNotNullString(self.txtNewPassword.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtNewPassword.text) == "" ? false : true
    }
    
    func validateConfirmPassword() {
        self.lblErrorConfirmPassword.text = getNotNullString(self.txtConfirmPassword.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : (getNotNullString(self.txtNewPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? "" : NSLocalizedString("passwordMustMatch", comment: ""))
        self.lblErrorConfirmPassword.isHidden = getNotNullString(self.txtConfirmPassword.text) == "" ? false : (getNotNullString(self.txtNewPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? true : false)
        self.viewConfirmPassword.layer.borderColor = getNotNullString(self.txtConfirmPassword.text) == "" ? UIColor(named: "RedColor")?.cgColor : (getNotNullString(self.txtNewPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? UIColor(named: "Black")?.cgColor : UIColor(named: "RedColor")?.cgColor)
        self.isValidated = getNotNullString(self.txtConfirmPassword.text) == "" ? false : (getNotNullString(self.txtNewPassword.text) == getNotNullString(self.txtConfirmPassword.text) ? true : false)
    }
    
    func validateFullName() {
        self.lblErrorFullName.text = getNotNullString(self.txtFullName.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : ""
        self.lblErrorFullName.isHidden = getNotNullString(self.txtFullName.text) == "" ? false : true
        self.viewFullName.layer.borderColor = getNotNullString(self.txtFullName.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtFullName.text) == "" ? false : true
    }
    
    func validatePhoneNumber() {
        self.lblErrorPhoneNumber.text = getNotNullString(self.txtPhoneNumber.text) == "" ? NSLocalizedString("fieldRequired", comment: "") : ""
        self.lblErrorPhoneNumber.isHidden = getNotNullString(self.txtPhoneNumber.text) == "" ? false : true
        self.viewPhoneNumber.layer.borderColor = getNotNullString(self.txtPhoneNumber.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtPhoneNumber.text) == "" ? false : true
    }
    
    func validateBio() {
        self.lblErrorBio.text = getNotNullString(self.txtBio.text) == NSLocalizedString("descBio", comment: "") ? NSLocalizedString("fieldRequired", comment: "") : ""
        self.lblErrorBio.isHidden = getNotNullString(self.txtBio.text) == "" ? false : true
        self.viewBio.layer.borderColor = getNotNullString(self.txtBio.text) == "" ? UIColor(named: "RedColor")?.cgColor : UIColor(named: "Black")?.cgColor
        self.isValidated = getNotNullString(self.txtBio.text) == NSLocalizedString("descBio", comment: "") ? false : true
    }
}

extension EditProfileVC : UITextFieldDelegate , UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !profileScrollView.isHidden {
            if textField == self.txtFullName {
                self.validateFullName()
            }
        }
        
        if !changePasswordScrollView.isHidden {
            if textField == self.txtOldPassword {
                self.validateOldPassword()
            }

            if textField == self.txtNewPassword {
                self.validateNewPassword()
            }

            if textField == self.txtConfirmPassword {
                self.validateConfirmPassword()
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.txtBio {
            validateBio()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == NSLocalizedString("descBio", comment: "") {
            self.txtBio.text = ""
        }
    }
}

extension EditProfileVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension EditProfileVC {
    func callChangePasswordAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executePostAPICallWithMethod(apiName: APIClient.API.changePassword, params: APIClient.Parameters.changePassword(user_id: NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserId) ?? "", oldPassword: getNotNullString(self.txtOldPassword.text) ?? "", newPassword: getNotNullString(self.txtNewPassword.text) ?? "").getParams()) { data, responseCode, error in
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
                    NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("passwordChangedSuccessFully", comment: "") , controller: self)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
    
    func callEditProfileAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executePostAPICallWithMethod(apiName: APIClient.API.editProfile, params: APIClient.Parameters.editProfile(user_id: NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserId) ?? "", userName: getNotNullString(self.txtFullName.text) ?? "", gender:  self.lblGender.text == NSLocalizedString("selectGender", comment: "") ? "" : self.lblGender.text ?? "", description: self.txtBio.text ?? "", pronounse: self.pronounsSegmentItem[self.pronounsSegment.selectedSegmentIndex] , mobileNumber: getNotNullString(self.txtPhoneNumber.text) ?? "", dob: self.lblDOB.text == NSLocalizedString("dob", comment: "") ? "" :self.lblDOB.text ?? "").getParams()) { data, responseCode, error in
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
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.UserName, valueParameter: getNotNullString(self.txtFullName.text) ?? "")
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Description, valueParameter: getNotNullString(self.txtBio.text) ?? "")
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Gender, valueParameter: getNotNullString(self.lblGender.text?.lowercased) ?? "")
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Mobile, valueParameter: getNotNullString(self.txtPhoneNumber.text) ?? "")
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.DOB, valueParameter: getNotNullString(self.lblDOB.text) ?? "")
                    NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: LoginUser.Pronouns, valueParameter:  self.pronounsSegmentItem[self.pronounsSegment.selectedSegmentIndex])

                    NSUtils.sharedInstance.showAlert(title: "", message: NSLocalizedString("profileEditedSuccessfully", comment: ""), controller: self)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                }
            }
        }
    }
}
