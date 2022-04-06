//
//  UIView+Constraints.swift
//  PinterestLayout
//
//  Created by Khrystyna Shevchuk on 7/7/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import AVFoundation


public extension UIImage {
    /**
     Calculates the best height of the image for available width.
     */
    public func height(forWidth width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: CGFloat(MAXFLOAT)
        )
        let rect = AVMakeRect(
            aspectRatio: size,
            insideRect: boundingRect
        )
        return rect.size.height
    }
}

public extension String {
    /**
     Calculates the best height of the text for available width and font used.
     */
    public func heightForWidth(width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: nil,
            context: nil
        )
        return ceil(rect.height)
    }
}

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}


//extension UIApplication {
//    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
//       
//        if let nav = base as? UINavigationController {
//            return topViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return topViewController(base: presented)
//        }
//        return base
//    }
//}

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!;
    }
}
