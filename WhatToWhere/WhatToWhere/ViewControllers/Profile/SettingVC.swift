//
//  SettingVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblStyleQuiz: UILabel!
    @IBOutlet weak var lblSecurity: UILabel!
    @IBOutlet weak var lblHelp: UILabel!
    @IBOutlet weak var lblContactUs: UILabel!
    @IBOutlet weak var lblAboutUs: UILabel!
    @IBOutlet weak var lblShareYourFeedback: UILabel!
    @IBOutlet weak var lblInviteAFriend: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnBlockAccount: UIButton!
    @IBOutlet var btnBlockAccountHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnPrivacySettings: UIButton!
    @IBOutlet var btnPrivacySettingsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnFAQ: UIButton!
    @IBOutlet var btnFAQHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnReportAnIssue: UIButton!
    @IBOutlet var btnReportAnIssueHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnTourGuide: UIButton!
    @IBOutlet var btnTourHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnOverView: UIButton!
    @IBOutlet var btnOverViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnWhatToWhere: UIButton!
    @IBOutlet var btnWhatToWhereHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnTermsConditions: UIButton!
    @IBOutlet var btnTermsConditionsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet var btnPrivacyPolicyHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var imgSecurityDropDown: UIImageView!
    @IBOutlet weak var imgHelpDropDown: UIImageView!
    @IBOutlet weak var imgAboutUsDropDown: UIImageView!
    
    @IBOutlet weak var viewSecurity: UIView!
    @IBOutlet weak var viewHelp: UIView!
    @IBOutlet weak var viewAboutUs: UIView!
    
    @IBOutlet weak var imgSecurityDropShadow: UIImageView!
    @IBOutlet weak var imgHelpDropShadow: UIImageView!
    @IBOutlet weak var imgAboutUsDropShadow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text = NSLocalizedString("settings", comment: "")
        self.lblEditProfile.text = NSLocalizedString("editProfile", comment: "")
        self.lblStyleQuiz.text = NSLocalizedString("styleQuiz", comment: "")
        self.lblSecurity.text = NSLocalizedString("security", comment: "")
        self.lblHelp.text = NSLocalizedString("help", comment: "")
        self.lblContactUs.text = NSLocalizedString("contactUs", comment: "")
        self.lblAboutUs.text = NSLocalizedString("aboutUs", comment: "")
        self.lblShareYourFeedback.text = NSLocalizedString("shareYourFeedback", comment: "")
        self.lblInviteAFriend.text = NSLocalizedString("inviteAFriend", comment: "")
        self.btnBlockAccount.setTitle("    \(NSLocalizedString("blockAccount", comment: ""))", for: .normal)
        self.btnPrivacySettings.setTitle("    \(NSLocalizedString("privacySettings", comment: ""))", for: .normal)
        self.btnFAQ.setTitle("    \(NSLocalizedString("faq", comment: ""))", for: .normal)
        self.btnReportAnIssue.setTitle("    \(NSLocalizedString("reportAnIssue", comment: ""))", for: .normal)
        self.btnTourGuide.setTitle("    \(NSLocalizedString("tourGuide", comment: ""))", for: .normal)
        self.btnWhatToWhere.setTitle("    \(NSLocalizedString("whatToWhere", comment: ""))", for: .normal)
        self.btnTermsConditions.setTitle("    \(NSLocalizedString("termsAndConditions", comment: ""))", for: .normal)
        self.btnPrivacyPolicy.setTitle("    \(NSLocalizedString("privacyPolicy", comment: ""))", for: .normal)
        self.btnLogout.setTitle(NSLocalizedString("logout", comment: ""), for: .normal)
        self.btnOverView.setTitle("    \(NSLocalizedString("overView", comment: ""))", for: .normal)
        self.imgHelpDropDown.image = UIImage(named: "more-arrow-icon")
        self.imgSecurityDropDown.image = UIImage(named: "more-arrow-icon")
        self.imgAboutUsDropDown.image = UIImage(named: "more-arrow-icon")
        
        self.btnBlockAccount.isHidden = true
        self.btnPrivacySettings.isHidden = true
        self.btnFAQ.isHidden = true
        self.btnReportAnIssue.isHidden = true
        self.btnTourGuide.isHidden = true
        self.btnWhatToWhere.isHidden = true
        self.btnTermsConditions.isHidden = true
        self.btnPrivacyPolicy.isHidden = true
        self.btnOverView.isHidden = true
        
        self.btnBlockAccountHeightConstraint.constant = 0
        self.btnPrivacySettingsHeightConstraint.constant = 0
        self.btnFAQHeightConstraint.constant = 0
        self.btnReportAnIssueHeightConstraint.constant = 0
        self.btnTourHeightConstraint.constant = 0
        self.btnWhatToWhereHeightConstraint.constant = 0
        self.btnTermsConditionsHeightConstraint.constant = 0
        self.btnPrivacyPolicyHeightConstraint.constant = 0
        self.btnOverViewHeightConstraint.constant = 0
        self.viewSecurity.backgroundColor = UIColor.clear
        self.viewHelp.backgroundColor = UIColor.clear
        self.viewAboutUs.backgroundColor = UIColor.clear
        
        self.imgSecurityDropShadow.isHidden = false
        self.imgHelpDropShadow.isHidden = false
        self.imgAboutUsDropShadow.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLogOutClicked(_ sender: Any) {
        self.callLogoutAPI()
    }

    @IBAction func btnEditProfileClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.EditProfileVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnStyleQuizeClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.StyleQuizeListVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnSecurityClicked(_ sender: Any) {
        if btnBlockAccount.isHidden {
            self.setupLayout()
            self.btnBlockAccount.isHidden = false
            self.btnPrivacySettings.isHidden = false
            self.btnBlockAccountHeightConstraint.constant = 50
            self.btnPrivacySettingsHeightConstraint.constant = 50
            self.imgSecurityDropShadow.isHidden = true
            self.viewSecurity.backgroundColor = UIColor(named: "LightGrey")
            self.imgSecurityDropDown.image = UIImage(named: "more-arrow-icon-down")

        } else {
            self.setupLayout()
        }
    }

    @IBAction func btnBlockUserClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.BlockedUserListVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnPrivacySettinClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.PrivacySettingVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnHelpClicked(_ sender: Any) {
        if btnFAQ.isHidden {
            self.setupLayout()
            self.btnFAQ.isHidden = false
            self.btnReportAnIssue.isHidden = false
            self.btnTourGuide.isHidden = false
            self.btnOverView.isHidden = false
            self.btnFAQHeightConstraint.constant = 50
            self.btnReportAnIssueHeightConstraint.constant = 50
            self.btnTourHeightConstraint.constant = 50
            self.btnOverViewHeightConstraint.constant = 50
            self.imgHelpDropShadow.isHidden = true
            self.viewHelp.backgroundColor = UIColor(named: "LightGrey")
            self.imgHelpDropDown.image = UIImage(named: "more-arrow-icon-down")
        } else {
            self.setupLayout()
        }
    }

    @IBAction func btnFAQClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.FAQVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnReportAnIssueClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.ReportAnIssueVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnTourGuideClicked(_ sender: Any) {
        let controller = PushMainControllerView.sharedInstance.TutorialVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnContactUsClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.ContactUsVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnAboutUsClicked(_ sender: Any) {
        if self.btnWhatToWhere.isHidden {
            self.setupLayout()
            self.btnWhatToWhere.isHidden = false
            self.btnTermsConditions.isHidden = false
            self.btnPrivacyPolicy.isHidden = false
            self.btnWhatToWhereHeightConstraint.constant = 50
            self.btnTermsConditionsHeightConstraint.constant = 50
            self.btnPrivacyPolicyHeightConstraint.constant = 50
            self.imgAboutUsDropShadow.isHidden = true
            self.viewAboutUs.backgroundColor = UIColor(named: "LightGrey")
            self.imgAboutUsDropDown.image = UIImage(named: "more-arrow-icon-down")

        } else {
            self.setupLayout()
        }
    }

    @IBAction func btnWhatToWhereClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.WhatToWhereVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnTermsConditionClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.TermsConditionVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnPrivacyPolicyClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.PrivacyPolicyVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnShareYourFeedBackClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.FeedBackVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnInviteAFriendClicked(_ sender: Any) {

    }

}

extension SettingVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension SettingVC {
    func callLogoutAPI() {
        APIClient().executeGetAPICallWithMethod(apiName: APIClient.API.logOut) { data, responseCode, error in
            if((error) != nil) {
                if((data) != nil){
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["message"] ?? "") , controller: self)
                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: error!.localizedDescription, controller: self)
                }
            } else {
                if responseCode == 200 {
                    let controller = PushAuthenticationControllerView.sharedInstance.SignInVC()
                    self.navigationController?.pushViewController(controller, animated: true)

                } else {
                    NSUtils.sharedInstance.showAlert(title: "", message: getNotNullString(data?["Message"] ?? "") , controller: self)
                }
            }
        }
    }
}
