//
//  NotificationFollowingStartedCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/04/22.
//

import Foundation
import UIKit

class NotificationFollowingStartedCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblNotificationInfo: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadNotificationFollowingStartedCell() {

        
    }
}
