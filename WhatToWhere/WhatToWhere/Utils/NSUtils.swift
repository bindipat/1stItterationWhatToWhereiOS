//
//  NSUtils.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 08/03/22.
//

import Foundation
import UIKit
import SystemConfiguration
import Reachability


class NSUtils : NSObject {
    static let sharedInstance = NSUtils()
    var device_token : String = String()
    var tabBar = TabBar()

    func saveValuetoUserDefault(keyParameter : String, valueParameter : Any) {
        let ud = UserDefaults.standard
        ud.set(valueParameter, forKey: keyParameter)
        ud.synchronize()
    }
    
    func getValuefromUserDefault(keyParameter : String)  -> String?{
        return UserDefaults.standard.string(forKey: keyParameter)
    }
    
    func showAlert(title: String?, message: String?, controller:UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Okay", comment: ""), style: .default) { (action) in
            print("\(String(describing: action.title))")
        }
        alert.addAction(okAction)
        alert.preferredAction = okAction
        
        DispatchQueue.main.async(execute: {
            controller?.present(alert, animated: true)
        })
    }

    func addTabBar(_ controller: UIViewController) {
        let window = UIApplication.shared.delegate!.window!
        let view = window?.viewWithTag(121)
        self.tabBar.view.tag = 121

        if !(view != nil) {
            if !(tabBar != nil) {
                self.tabBar = TabBar(nibName: "TabBar", bundle: nil)
            }
            
            self.tabBar.view.tag = 121
        }
        
        var isAdded : Bool = false
        for i: UIView? in controller.view.subviews {
            if (i != nil) {
                let newView = i
                if newView?.tag == 121 {
                    isAdded = true
                    break
                }
            } else{
                break
            }
        }
        if isAdded == false
        {
            controller.view.addSubview(tabBar.view)
        }
        tabBar.view.frame = CGRect(x: 0, y: (window?.frame.size.height)! - 70, width: (window?.frame.size.width)!, height: 60)
    }

    func removeTabBar() {
        tabBar.view.removeFromSuperview()
    }
    
    func hideTabBar() {
        tabBar.view.isHidden = true
    }
    
    func unHideTabBar() {
        tabBar.view.isHidden = false
    }

    func convertStringToDate(strDate : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from:strDate)!
        return date
    }
    
}
