//
//  BlockedUserListCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 24/03/22.
//

import Foundation
import UIKit

class BlockedUserListCell: UITableViewCell {
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnUnBlockUser: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadBlockedListCell() {
        
    }
}
