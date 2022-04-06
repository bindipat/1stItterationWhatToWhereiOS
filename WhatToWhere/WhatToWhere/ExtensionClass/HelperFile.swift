//
//  HelperFile.swift
//  FirstMessengerApp
//
//  Created by Vivek Shukla on 07/12/21.
//

import Foundation
import UIKit

//MARK: Manage ROOM ID
//func manageRoomSID(_ form: String?) -> String{
//    let toUser = UserData.getMemberSID()!.components(separatedBy: "-").last!
//    let fromUser  = "\(form!.components(separatedBy: "-").last!)"
//    return "\(toUser)\(fromUser)"
//}
//
//
////MARK: Manage ROOM ID IF Store Data Nill Find
//func manageRoomFindNillSID(_ form: String?) -> String{
//    let toUser = UserData.getMemberSID()!.components(separatedBy: "-").last!
//    let fromUser  = "\(form!.components(separatedBy: "-").last!)"
//    return "\(fromUser)\(toUser)"
//}

//Register Nib file
func registerCells(_ tableView: UITableView, names: [String]) {
    for name in names{
        tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}

//MARK: manage String File
func getNotNullString(_ string: Any?) -> String? {
    var sourceStr = ""
    
    if (string is NSNumber) {
        sourceStr = (string as? NSNumber)?.stringValue ?? ""
    } else {
        sourceStr = "\(string as? String ?? "")"
    }
    if (sourceStr == "(null)") {
        sourceStr = ""
    }
    if (sourceStr == "<null>") {
        sourceStr = ""
    }
    if (sourceStr == "<nil>") {
        sourceStr = ""
    }
    if sourceStr.count == 0 {
        sourceStr = ""
    }
    //    if sourceStr == nil {
    //        sourceStr = ""
    //    }
    return sourceStr
}

func removeBlurView(_ imgView: UIImageView){
    for subview in imgView.subviews {
        if subview is UIVisualEffectView {
            subview.removeFromSuperview()
        }
    }
}


//MARK : Manage Tab Bar Index
//func tabViewController(_ index : Int){
//    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//    initialViewController.selectedIndex = index
//    appDelegate.window?.rootViewController = initialViewController
//    appDelegate.window?.makeKeyAndVisible()
//}


//MARK:- Corner Radius of only two side of UIViews
func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
}
