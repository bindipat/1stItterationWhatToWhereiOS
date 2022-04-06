//
//  LeaderBoardCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/04/22.
//

import Foundation
import UIKit

class LeaderBoardCell: UITableViewCell {
    
    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgUserProfilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadNotificationShareLikeCommnetCell() {

        
    }
}
