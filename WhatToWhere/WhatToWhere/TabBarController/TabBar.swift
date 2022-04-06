//
//  TabBar.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 18/03/22.
//

import Foundation
import UIKit
import GoogleMobileAds

typealias ActionClosure = @convention(block) () -> ()
class TabBar: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnUploadPost: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    
    var pickerController = UIImagePickerController()
    
    var imagedata : Data = Data()
    var pickedVideoURL : URL!
//    @IBOutlet weak var bannerView: GADBannerView!
//    @IBOutlet var bannerViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    func setUpView() {
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//          bannerView.delegate = self
//        bannerView.load(GADRequest())

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnHomeTabClicked(_ sender: Any) {
        self.btnHome.tag = 0
        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)

        self.btnHome.setImage(UIImage(named: "active-home"), for: .normal)
        self.btnUploadPost.setImage(UIImage(named: "in-active-camera"), for: .normal)
        self.btnNotification.setImage(UIImage(named: "in-active-notification"), for: .normal)
        self.btnProfile.setImage(UIImage(named: "in-active-user"), for: .normal)
        
        let homeRootVC = PushHomeControllerView.sharedInstance.HomeVC()
        Application.Delegate.navigationController?.pushViewController(homeRootVC, animated: false)
        Application.Delegate.window?.rootViewController = Application.Delegate.navigationController
    }
    
    @IBAction func btnNotificationTabClicked(_ sender: Any) {
        self.btnProfile.tag = 0
        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)

        self.btnHome.setImage(UIImage(named: "in-active-home"), for: .normal)
        self.btnUploadPost.setImage(UIImage(named: "in-active-camera"), for: .normal)
        self.btnNotification.setImage(UIImage(named: "active-notification"), for: .normal)
        self.btnProfile.setImage(UIImage(named: "in-active-user"), for: .normal)
        
        let notificationRootVC = PushNotificationControllerView.sharedInstance.NotificationListVC()
        Application.Delegate.navigationController?.pushViewController(notificationRootVC, animated: false)
        Application.Delegate.window?.rootViewController = Application.Delegate.navigationController
    }
    
    @IBAction func btnProfileTabClicked(_ sender: Any) {
        self.btnProfile.tag = 0

        self.btnHome.setImage(UIImage(named: "in-active-home"), for: .normal)
        self.btnUploadPost.setImage(UIImage(named: "in-active-camera"), for: .normal)
        self.btnNotification.setImage(UIImage(named: "in-active-notification"), for: .normal)
        self.btnProfile.setImage(UIImage(named: "active-user"), for: .normal)
        
        let profileRootVC = PushProfileControllerView.sharedInstance.ProfileVC()
        Application.Delegate.navigationController?.pushViewController(profileRootVC, animated: false)
        Application.Delegate.window?.rootViewController = Application.Delegate.navigationController

    }
        
    @IBAction func btnUploadClicked(_ sender: Any) {
        
        self.btnProfile.tag = 0
        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil)
        
        let postRootVC = PushPostControllerView.sharedInstance.CustomCameraV()
        Application.Delegate.navigationController?.pushViewController(postRootVC, animated: false)
        Application.Delegate.window?.rootViewController = Application.Delegate.navigationController

    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        pickedVideoURL = info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? URL
        print("videoURL:\(String(describing: pickedVideoURL))")

        picker.dismiss(animated: false)
        {
//            self.callUploadVideoAPI()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
        {
            NSUtils.sharedInstance.addTabBar(self)
        }
    }

//    func callUploadVideoAPI() {
//
//        ManagerClass.sharedInstance.addTabBar(self)
//
//        let arrFile: NSMutableArray = NSMutableArray()
//        if pickedVideoURL != nil
//        {
//            arrFile.add(ManagerClass.sharedInstance.getDictForVideoUpload(videoURL: pickedVideoURL, strName: "upload_file[]"))
//        }
//
//        let dicEditProfile : [String : String] = ["user_id" : String(format : "%@", (UserDefaults.standard.value(forKey: Key.KeyUserDetail) as! NSDictionary).object(forKey: "user_id") as! String)]
//
//        Application.Delegate.showHudWithLable(nil)
//
//        APIClient.uploadVideo(Detail: dicEditProfile as NSDictionary, ImageData: arrFile) { (data, error) in
//            if((error) != nil) {
//                Application.Delegate.hideHUD(true)
//                if((data) != nil){
//                    UIAlertController.showAlert(in: self, withTitle: "", message: data?.object(forKey: "message") as? String, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: { (controller, action, buttonIndex) in
//                    })
//                } else {
//                    UIAlertController.showAlert(in: self, withTitle: "", message: error!.localizedDescription, cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: { (controller, action, buttonIndex) in
//                    })
//                }
//            } else
//            {
//                Application.Delegate.hideHUD(true)
//                if data?.object(forKey: "status") as! Bool == true {
//                    UIAlertController.showAlert(in: self, withTitle: "", message: "Uploaded successfully", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: { (controller, action, buttonIndex) in
//
//                        self.dismiss(animated: true, completion: nil)
//
//                    })
//                }
//                else {
////                    UIAlertController.showAlert(in: self, withTitle: "", message: "Video uploaded successfully", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tap: { (controller, action, buttonIndex) in
////
////                    })
//                }
//            }
//        }
//    }
    
}

//extension TabBar : GADBannerViewDelegate {
//    
//    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//      print("bannerViewDidReceiveAd")
//        self.bannerViewHeightConstraint.constant = 50
//    }
//
//    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
//        self.bannerViewHeightConstraint.constant = 0
//    }
//
//    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
//      print("bannerViewDidRecordImpression")
//        self.bannerViewHeightConstraint.constant = 50
//    }
//
//    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillPresentScreen")
//    }
//
//    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillDIsmissScreen")
//    }
//
//    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewDidDismissScreen")
//    }
//
//}
