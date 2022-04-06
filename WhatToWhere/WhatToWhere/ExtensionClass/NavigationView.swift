//
//  PushControllerView.swift
//  FirstMessengerApp
//
//  Created by Vivek Shukla on 07/12/21.
//

import Foundation
import UIKit


open class NavigatorContainer {
    
    fileprivate var container: [String : UINavigationController] = [ : ]
    
    public init() {
    }
    
    open func register<T: UINavigationController>(_ navigationController: T) -> T {
        container[String(describing: T.self)] = navigationController
        return navigationController
    }
    
    open func resolve<T: UINavigationController>() -> T? {
        return (container[String(describing: T.self)] as! T)
    }
}

open class ReportAnIssueNavigatorContainer {
    
    fileprivate var container: [String : UINavigationController] = [ : ]
    
    public init() {
    }
    
    open func register<T: UINavigationController>(_ navigationController: T) -> T {
        container[String(describing: T.self)] = navigationController
        return navigationController
    }
    
    open func resolve<T: UINavigationController>() -> T? {
        return (container[String(describing: T.self)] as! T)
    }
}
