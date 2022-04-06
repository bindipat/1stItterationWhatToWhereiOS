//
//  NSString+emailValidation.swift
//  COL
//
//  Created by ASquareDigitalSolution8 on 5/10/16.
//  Copyright © 2016 Kukd. All rights reserved.
//

import UIKit

extension String {
    
    func take(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }

    public func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
            options: [.caseInsensitive])
        
        return regex.firstMatch(in: self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
    
    public func isValidPhoneNumber() -> Bool {
        let regx = try! NSRegularExpression(pattern: "^[0-9]{8,14}$", options: [])
        
        return regx.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
        
//        NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";

    }
    
    
    public func isValidWebSiteURL() -> Bool {
                let regx = try! NSRegularExpression(pattern: "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$", options: [])
        return regx.firstMatch(in: self, options: [], range: NSMakeRange(0, utf16.count)) != nil
    }
    
    public func isStringAnInt() -> Bool {
        return Int(self) != nil
    }

    public func isTextFieldHaveValue(txt: String) -> Bool {
        let sortedfield = txt.replacingOccurrences(of: " ", with: "")
        if sortedfield.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    func isPwdLenth(password: String) -> Bool {
        if (!(password.count < 5 || password.count > 20)){
            return true
        }
        else{
            return false
        }
    }
    
    func checkRequiredField(field : String) -> Bool {
       let sortedfield = field.replacingOccurrences(of: " ", with: "")

        if sortedfield.count > 0 {
            return false
        } else {
            return true
        }
    }
}

extension NSString {
    
    public func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
                                             options: [.caseInsensitive])
        
        return regex.firstMatch(in: self as String, options:[],
                                        range: NSMakeRange(0, self.length)) != nil
    }
}
