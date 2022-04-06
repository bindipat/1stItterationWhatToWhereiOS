//
//  FollowingsListCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 25/03/22.
//

import Foundation
import UIKit
import SDWebImage

class FollowingsListCell: UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnFollowing: UIButton!
    @IBOutlet weak var btnMoreAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadFollowingsListCell(dataModel : FollowingsListDataModel) {
        self.lblUserName.text = getNotNullString(dataModel.userName) ?? ""
        self.btnFollowing.setTitle(NSLocalizedString("following", comment: ""), for: .normal)
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
