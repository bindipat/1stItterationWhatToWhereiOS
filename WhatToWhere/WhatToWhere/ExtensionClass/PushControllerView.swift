//
//  PushControllerView.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class PushAuthenticationControllerView {
    static let sharedInstance = PushAuthenticationControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
    
    func OverViewVC() -> OverViewVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "OverViewVC") as! OverViewVC
        return controller
    }
    
    func SignInVC() -> SignInVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        return controller
    }

    func SignUpVC() -> SignUpVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        return controller
    }

    func ForgotPasswordVC() -> ForgotPasswordVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        return controller
    }

    func VerificationVC() -> VerificationVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
        return controller
    }

    func RecoverPasswordVC() -> RecoverPasswordVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "RecoverPasswordVC") as! RecoverPasswordVC
        return controller
    }

}

class PushProfileControllerView {
    static let sharedInstance = PushProfileControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    
    func PrivacyPolicyVC() -> PrivacyPolicyVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
        return controller
    }
    
    func TermsConditionVC() -> TermsConditionVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsConditionVC") as! TermsConditionVC
        return controller
    }

    func WhatToWhereVC() -> WhatToWhereVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "WhatToWhereVC") as! WhatToWhereVC
        return controller
    }

    func EditProfileVC() -> EditProfileVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        return controller
    }
    
    func ProfileVC() -> ProfileVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        return controller
    }

    func FollowerFollowingListVC() -> FollowerFollowingListVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "FollowerFollowingListVC") as! FollowerFollowingListVC
        return controller
    }
        
    func SettingVC() -> SettingVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        return controller
    }

    func BlockedUserListVC() -> BlockedUserListVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "BlockedUserListVC") as! BlockedUserListVC
        return controller
    }

    func PrivacySettingVC() -> PrivacySettingVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "PrivacySettingVC") as! PrivacySettingVC
        return controller
    }

    func FAQVC() -> FAQVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "FAQVC") as! FAQVC
        return controller
    }

    func ReportAnIssueVC() -> ReportAnIssueVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "ReportAnIssueVC") as! ReportAnIssueVC
        return controller
    }

    func ContactUsVC() -> ContactUsVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        return controller
    }
    
    func FeedBackVC() -> FeedBackVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "FeedBackVC") as! FeedBackVC
        return controller
    }

    func StyleQuizeListVC() -> StyleQuizeListVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "StyleQuizeListVC") as! StyleQuizeListVC
        return controller
    }


}

class PushMainControllerView {
    static let sharedInstance = PushMainControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func TutorialVC() -> TutorialVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
        return controller
    }
    
    func FirstIntroVC() -> FirstIntroVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "FirstIntroVC") as! FirstIntroVC
        return controller
    }

    func SecondIntroVC() -> SecondIntroVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondIntroVC") as! SecondIntroVC
        return controller
    }

    func ThirdIntroVC() -> ThirdIntroVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "ThirdIntroVC") as! ThirdIntroVC
        return controller
    }

    func FourthIntroVC() -> FourthIntroVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "FourthIntroVC") as! FourthIntroVC
        return controller
    }
    
    func SplashScreenVC() -> SplashScreenVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SplashScreenVC") as! SplashScreenVC
        return controller
    }


}

class PushHomeControllerView {
    static let sharedInstance = PushHomeControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    
    func HomeVC() -> HomeVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        return controller
    }
    
    func SetupProfileVC() -> SetupProfileVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SetupProfileVC") as! SetupProfileVC
        return controller
    }

    func SetupStyleQuizeVC() -> SetupStyleQuizeVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "SetupStyleQuizeVC") as! SetupStyleQuizeVC
        return controller
    }

    
}

class PushNotificationControllerView {
    static let sharedInstance = PushNotificationControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Notification", bundle: nil)
    
    func NotificationListVC() -> NotificationListVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "NotificationListVC") as! NotificationListVC
        return controller
    }
    
}

class PushPostControllerView {
    static let sharedInstance = PushPostControllerView()
    let navigatorContainer = NavigatorContainer()
    let reportAnIssueNavigatorContainer = ReportAnIssueNavigatorContainer()
    let storyboard = UIStoryboard(name: "Post", bundle: nil)
    
    func CustomCameraV() -> CustomCameraVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "CustomCameraVC") as! CustomCameraVC
        return controller
    }
    
    func AddCaptionToPostVC() -> AddCaptionToPostVC {
        let controller = storyboard.instantiateViewController(withIdentifier: "AddCaptionToPostVC") as! AddCaptionToPostVC
        return controller
    }
}


