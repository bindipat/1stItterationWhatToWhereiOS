//
//  FAQCell.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 26/03/22.
//

import Foundation
import UIKit

class FAQCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadFAQCell() {

        
    }
}
