//
//  FourthIntroVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 06/03/22.
//

import Foundation
import UIKit

class FourthIntroVC: UIViewController {
    
    @IBOutlet weak var lblMainIntro: UILabel!
    @IBOutlet weak var lblDetailIntro: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
}
