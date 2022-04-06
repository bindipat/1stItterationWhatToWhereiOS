//
//  ProfileVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/03/22.
//

import Foundation
import UIKit
import RESegmentedControl
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserBio: UILabel!
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var lblFollowingsCount: UILabel!
    @IBOutlet weak var lblFollowersTitle: UILabel!
    @IBOutlet weak var lblFollowingsTitle: UILabel!
    @IBOutlet weak var lblPronounse: UILabel!
    @IBOutlet weak var lblPointsTitle: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var imgIsVerified: UIImageView!
    @IBOutlet weak var profileView: UIView!
 
    let wardRobeInspirationSegmentItem = [NSLocalizedString("wardrobe", comment: ""), NSLocalizedString("inspiration", comment: "")]

    @IBOutlet weak var wardRobeInspirationSegment: RESegmentedControl! {
        didSet {
            var segmentItems: [SegmentModel] {
                return wardRobeInspirationSegmentItem.map({ SegmentModel(title: $0) })
            }
            
            var preset = MaterialPreset(backgroundColor: .clear, tintColor: UIColor(named: "Black")!)

            preset.segmentItemAxis = .vertical
            preset.textColor = UIColor(named: "Black")!
            preset.selectedTextColor = UIColor(named: "Black")!
            preset.textFont = UIFont(name: FontName.DMSans_Regular, size: 16)!
            preset.selectedTextFont = UIFont(name: FontName.DMSans_Medium, size: 16)!

            wardRobeInspirationSegment.configure(segmentItems: segmentItems, preset: preset)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblFollowersTitle.text = NSLocalizedString("followers", comment: "")
        self.lblFollowingsTitle.text = NSLocalizedString("following", comment: "")
        self.lblUserName.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserName)
        self.lblUserBio.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.Description)
        self.lblFollowersCount.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.FollowerCount)
        self.lblFollowingsCount.text = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.FollowingCount)
        self.lblPointsTitle.text = NSLocalizedString("points", comment: "")
        if let encoded = getNotNullString(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.ProfileImage))?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            self.imgProfilePicture.sd_setImage(with: myURL, placeholderImage: UIImage(named: "user-profile-placeholder.png"), options: SDWebImageOptions.progressiveLoad , completed: { (_ image: UIImage?, _ error: Error?,  _ cacheType: SDImageCacheType, _ imageURL: URL?) in
                if image != nil {
                    self.imgProfilePicture.image = image
                }
            })
        }
        
        NSUtils.sharedInstance.addTabBar(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func btnSettingClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.SettingVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnFollowingsClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.FollowerFollowingListVC()
        controller.strNavigationTitle = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserName) ?? ""
        controller.selectedSegment = 1
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnFollowersClicked(_ sender: Any) {
        let controller = PushProfileControllerView.sharedInstance.FollowerFollowingListVC()
        controller.strNavigationTitle = NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserName) ?? ""
        controller.selectedSegment = 0
        self.navigationController?.pushViewController(controller, animated: true)
    }
       
    @IBAction func btnFacebookClicked(_ sender: Any) {
        
    }
    
    @IBAction func btnInstagramClicked(_ sender: Any) {
        
        guard let url = URL(string: "https://instagram.com/\(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserName) ?? "")")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func btnTikTokeClicked(_ sender: Any) {
    }
    
    @IBAction func btnYoutubeClicked(_ sender: Any) {
    }
}

extension ProfileVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
