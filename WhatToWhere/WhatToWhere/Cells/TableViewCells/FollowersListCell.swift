//
//  FollowersListCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 25/03/22.
//

import Foundation
import UIKit
import SDWebImage

class FollowersListCell: UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnRemove: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadFollowersListCell(dataModel : FollowersListDataModel) {
        self.lblUserName.text = getNotNullString(dataModel.userName) ?? ""
        self.btnRemove.setTitle(NSLocalizedString("remove", comment: ""), for: .normal)
        if let encoded = getNotNullString(dataModel.profileImage)?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            self.imgUserProfile.sd_setImage(with: myURL, placeholderImage: UIImage(named: "user-profile-placeholder.png"), options: SDWebImageOptions.progressiveLoad , completed: { (_ image: UIImage?, _ error: Error?,  _ cacheType: SDImageCacheType, _ imageURL: URL?) in
                if image != nil {
                    self.imgUserProfile.image = image
                }
            })
        }

    }
}
