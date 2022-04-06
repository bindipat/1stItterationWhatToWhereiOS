//
//  BlockedUserListVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class BlockedUserListVC: UIViewController {
    
    @IBOutlet weak var tblBlockedUserList: UITableView!
    @IBOutlet weak var txtSearchUser: UITextField!
    @IBOutlet weak var lblNavTitle: UILabel!
    
    var page: Int = 1
    var totalNumberOfPage: Int = 0
    var isLoading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text = NSLocalizedString("blockAccount", comment: "")
        self.tblBlockedUserList.register(UINib.init(nibName: "BlockedUserListCell", bundle: nil) , forCellReuseIdentifier: "BlockedUserListCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
 
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TableView Delegate & DataSource
extension BlockedUserListVC: UITableViewDelegate, UITableViewDataSource {
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
        let myCell = tableView.dequeueReusableCell(withIdentifier: "BlockedUserListCell") as! BlockedUserListCell
        myCell.selectionStyle = .none
        
        return myCell
    }
}

extension BlockedUserListVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

//MARK: - API Call
extension BlockedUserListVC {
    func callBlockUserListAPI() {
        
    }
}
