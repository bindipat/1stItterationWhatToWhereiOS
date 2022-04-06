//
//  NotificationListVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/03/22.
//

import Foundation
import UIKit

class NotificationListVC: UIViewController {
    
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var lblLeaderBoardTitle: UILabel!
    @IBOutlet weak var imgFirstRunnerUpUserProfilePicture: UIImageView!
    @IBOutlet weak var imgSecondRunnerUpUserProfilePicture: UIImageView!
    @IBOutlet weak var imgThirdRunnerUpUserProfilePicture: UIImageView!
    
    
    @IBOutlet weak var tblNotificationList: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text = NSLocalizedString("notifications", comment: "")
        self.lblLeaderBoardTitle.text = NSLocalizedString("leaderboard", comment: "")
        self.imgFirstRunnerUpUserProfilePicture.image = UIImage(named: "user-profile-placeholder.png")
        self.imgSecondRunnerUpUserProfilePicture.image = UIImage(named: "user-profile-placeholder.png")
        self.imgThirdRunnerUpUserProfilePicture.image = UIImage(named: "user-profile-placeholder.png")
        registerCells(self.tblNotificationList, names: ["NotificationFollowingStartedCell","NotificationShareLikeCommnetCell"])

    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func btnNavigateToLeaderBoardClicked(_ sender: Any) {
        
    }
}

extension NotificationListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell : UITableViewCell = UITableViewCell()
        mainCell.selectionStyle = .none

        if indexPath.row % 2 == 0 {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "NotificationFollowingStartedCell") as! NotificationFollowingStartedCell
            myCell.selectionStyle = .none
            
            mainCell == myCell
        } else {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "NotificationFollowingStartedCell") as! NotificationFollowingStartedCell
            myCell.selectionStyle = .none
            
            mainCell == myCell

        }
        
        return mainCell
    }
}

extension NotificationListVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
