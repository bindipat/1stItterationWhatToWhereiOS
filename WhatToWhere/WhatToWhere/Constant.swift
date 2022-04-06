//
//  Constant.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

let TIMESTAMP = String(format: "%ld", Int(TimeInterval(Date().timeIntervalSince1970 * 1000)))

struct ApiConstants {
    static let kBaseURL = "http://whattowhere.net.162-222-225-85.plesk-web9.webhostbox.net/api/" // Development Server
//    static let kBaseURL = "https://1stmessenger-api-staging.azurewebsites.net/" // Staging Server
    static let kShareProfile = "https://1stmessenger-systemadminui-dev.azurewebsites.net/profile/"
}

struct Key {
    static let KEYInitialView = "LOGINID"
    static let KEYStartingView = "STARTINGID"
    static let KeyIsSocialMedia = "is_SocialMedia"
    static let KeyAuthenticationToken = "auth_token"
    static let KeyUserID = "userId"
    static let KeyTimeStamp = (Int((TimeInterval)(Date().timeIntervalSince1970 * 1000)))
}

struct FontName {
    static let Dalime_Regular = "Dalime"
    static let DMSans_Bold = "DMSans-Bold"
    static let DMSans_Medium = "DMSans-Medium"
    static let DMSans_Regular = "DMSans-Regular"
    static let OoohBaby_Regular = "OoohBaby-Regular"
}

struct MediaAccountKey {
    static let Google_ClientID = "1072224362091-s7s30n5f9fgcbk9c3p3i9eru4e13jk0h.apps.googleusercontent.com"
}

struct Application {
    static let Delegate = UIApplication.shared.delegate as! AppDelegate
}

struct LoginUser {
    static let UserId = "UserId"
    static let UserName = "UserName"
    static let Email = "Email"
    static let Gender = "Gender"
    static let ProfileImage = "ProfileImage"
    static let LoginType = "LoginType"
    static let IsEmailVerified = "IsEmailVerified"
    static let FirebaseToken = "FirebaseToken"
    static let IsActive = "IsActive"
    static let DeviceType = "DeviceType"
    static let DOB = "DOB"
    static let Mobile = "Mobile"
    static let Description = "Description"
    static let FollowingCount = "FollowingCount"
    static let FollowerCount = "FollowerCount"
    static let LoginFirst = "LoginFirst"
    static let InitialVC = "InitialVC"
    static let Pronouns = "Pronouns"
    static let AccessToken = "Access_Token"
}


struct LoginType {
    static let NormalLogin = "normal"
    static let FacebookLogin = "facebook"
    static let GmailLogin = "gmail"
    static let AppleLogin = "apple"
}
