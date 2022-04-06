//
//  SplashScreenVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 03/04/22.
//

import Foundation
import UIKit

class SplashScreenVC: UIViewController {
    
    @IBOutlet weak var lblNavTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        self.setupLayout()
    }
 
    func setupLayout() {
        self.lblNavTitle.text = NSLocalizedString("whatToWhere", comment: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.integer(forKey: Key.KEYInitialView) == 1 {
//            let controller = PushHomeControllerView.sharedInstance.HomeVC()
//            navigationController = UINavigationController(rootViewController: controller)
//            window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = navigationController
//
//        } else if UserDefaults.standard.integer(forKey: Key.KEYInitialView) == 2 {
//            let controller = PushAuthenticationControllerView.sharedInstance.OverViewVC()
//            navigationController = UINavigationController(rootViewController: controller)
//            window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = navigationController
//        }
//        else {
//            let controller = PushMainControllerView.sharedInstance.TutorialVC()
//            navigationController = UINavigationController(rootViewController: controller)
//            window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = navigationController
//        }

    }
}
