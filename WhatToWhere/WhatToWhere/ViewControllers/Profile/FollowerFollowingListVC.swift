//
//  FollowersListVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/03/22.
//

import Foundation
import UIKit
import RESegmentedControl

class FollowerFollowingListVC: UIViewController {
    
    @IBOutlet weak var tblFollowerFollowing: UITableView!
    @IBOutlet weak var txtSearchUser: UITextField!
    @IBOutlet weak var lblNavTitle: UILabel!
    
    var page: Int = 1
    var totalNumberOfPage: Int = 0
    var isLoading: Bool = true
    
    @IBOutlet weak var imgLoading: UIImageView!
    @IBOutlet weak var viewLoading: UIView!

    var arrFollowersList : [FollowersListDataModel] = []
    var arrFollowingsList : [FollowingsListDataModel] = []
    var strNavigationTitle = String()
    var selectedSegment : Int = 0
    
    let followersFollowingSegmentItem = ["\(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.FollowerCount) ?? "") \(NSLocalizedString("followers", comment: ""))", "\(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.FollowingCount) ?? "") \(NSLocalizedString("following", comment: ""))"]

    @IBOutlet weak var followersFollowingSegment: RESegmentedControl! {
        didSet {
            var segmentItems: [SegmentModel] {
                return followersFollowingSegmentItem.map({ SegmentModel(title: $0) })
            }
            
            var preset = MaterialPreset(backgroundColor: .clear, tintColor: UIColor(named: "Black")!)

            preset.segmentItemAxis = .vertical
            preset.textColor = UIColor(named: "Black")!
            preset.selectedTextColor = UIColor(named: "Black")!
            preset.textFont = UIFont(name: FontName.DMSans_Regular, size: 16)!
            preset.selectedTextFont = UIFont(name: FontName.DMSans_Medium, size: 16)!

            followersFollowingSegment.configure(segmentItems: segmentItems, preset: preset)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text =  strNavigationTitle

        registerCells(self.tblFollowerFollowing, names: ["FollowersListCell","FollowingsListCell"])
        
        self.followersFollowingSegment.selectedSegmentIndex = selectedSegment
        if self.selectedSegment == 0 {
            self.callFollowersListAPI()
        } else {
            self.callFollowingsListAPI()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
 
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentedControlChangedValue(_ sender: RESegmentedControl) {
        print(sender.selectedSegmentIndex)
        self.tblFollowerFollowing.reloadData()
        if sender.selectedSegmentIndex == 0 {
            self.callFollowersListAPI()
        } else {
            self.callFollowingsListAPI()
        }

    }
    
    @objc func btnRemoveFollowersClicked(_ sender : UIButton) {
        
    }

}

//MARK: - TableView Delegate & DataSource
extension FollowerFollowingListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if followersFollowingSegment.selectedSegmentIndex == 0 {
            return self.arrFollowersList.count
        } else {
            return self.arrFollowingsList.count
        }
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
        
        if self.followersFollowingSegment.selectedSegmentIndex == 0 {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "FollowersListCell") as! FollowersListCell
            myCell.reloadFollowersListCell(dataModel: self.arrFollowersList[indexPath.row])
            myCell.btnRemove.tag = indexPath.row
            myCell.btnRemove.addTarget(self, action: #selector(self.btnRemoveFollowersClicked(_:)), for: .touchUpInside)
            mainCell = myCell
        } else {
            let myCell = tableView.dequeueReusableCell(withIdentifier: "FollowingsListCell") as! FollowingsListCell
            myCell.reloadFollowingsListCell(dataModel: self.arrFollowingsList[indexPath.row])
            mainCell = myCell
        }
        
        return mainCell
    }
}

extension FollowerFollowingListVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension FollowerFollowingListVC {
    func callFollowersListAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executeGetAPICallWithMethod(apiName: "\(APIClient.API.followersList)?UserId=\(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserId) ?? "")") { data, responseCode, error in
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
                            let followersData = try? JSONDecoder().decode(FollowersListResponseModel.self, from: properData) as FollowersListResponseModel
                            self.arrFollowersList = (followersData?.data)!
                            self.tblFollowerFollowing.reloadData()
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
    
    func callFollowingsListAPI() {
        viewLoading.isHidden = false
        imgLoading.isHidden = false
        imgLoading.loadGif(name: "loading")
        APIClient().executeGetAPICallWithMethod(apiName: "\(APIClient.API.followingsList)?UserId=\(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.UserId) ?? "")") { data, responseCode, error in
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
                            let followingsData = try? JSONDecoder().decode(FollowingsListResponseModel.self, from: properData) as FollowingsListResponseModel
                            self.arrFollowingsList = (followingsData?.data)!
                            self.tblFollowerFollowing.reloadData()
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
    
    func btnRemoveFollowersAPI(strFoollowerID : String) {
        
    }
}
