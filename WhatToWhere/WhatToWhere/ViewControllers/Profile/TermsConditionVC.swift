//
//  TermsConditionVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit
import WebKit

class TermsConditionVC: UIViewController , WKUIDelegate {

    @IBOutlet weak var termsConditionWebView: WKWebView!
    @IBOutlet weak var lblNavTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        if #available(iOS 13.0, *) {
            self.view.overrideUserInterfaceStyle = .light
        }

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.lblNavTitle.text = NSLocalizedString("navTermsCondition", comment: "")
        let myURL = URL(string:"https://1stmessenger.com/privacy-policy")
        let myRequest = URLRequest(url: myURL!)
        termsConditionWebView.load(myRequest)

        // Do any additional setup after loading the view.
    }
 
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension TermsConditionVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension TermsConditionVC: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}
