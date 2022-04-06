//
//  StringExtension.swift
//  COL
//
//  Created by Asquare on 20/04/16.
//  Copyright © 2016 Kukd. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return self.count
    }
    
    // Add property localized string return for language base
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
