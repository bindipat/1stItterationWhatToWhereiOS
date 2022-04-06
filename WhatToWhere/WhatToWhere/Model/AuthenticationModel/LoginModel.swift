//
//  LoginModel.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 13/03/22.
//

import Foundation
import SwiftyJSON

struct LoginResponseModel: Codable {
    let message: String?
    let issuccess: Bool?
    let data: LoginDataModel?

    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case issuccess = "issuccess"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        data = try values.decodeIfPresent(LoginDataModel.self, forKey: .data)
    }

}

// MARK: - Login
struct LoginDataModel: Codable {
    let userID: Int?
    let userName, password, email, gender: String?
    let profileImage, loginType: String?
    let isEmailVerified: Bool?
    let firebaseToken: String?
    let isActive: Bool?
    let deviceType: String?
    let dob, mobile, userBio, pronouns: String?
    let followingCount, followerCount: Int?
    let loginFirst: Bool?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {
        case userID = "UserId"
        case userName = "UserName"
        case password = "Password"
        case email = "Email"
        case gender = "Gender"
        case profileImage = "ProfileImage"
        case loginType = "LoginType"
        case isEmailVerified = "IsEmailVerified"
        case firebaseToken = "FirebaseToken"
        case isActive = "IsActive"
        case deviceType = "DeviceType"
        case dob = "DOB"
        case mobile = "Mobile"
        case userBio = "Description"
        case pronouns = "Pronouns"
        case followingCount = "FollowingCount"
        case followerCount = "FollowerCount"
        case loginFirst = "LoginFirst"
        case accessToken = "Access_Token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userID = try values.decodeIfPresent(Int.self, forKey: .userID)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        firebaseToken = try values.decodeIfPresent(String.self, forKey: .firebaseToken)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        userBio = try values.decodeIfPresent(String.self, forKey: .userBio)
        followingCount = try values.decodeIfPresent(Int.self, forKey: .followingCount)
        followerCount = try values.decodeIfPresent(Int.self, forKey: .followerCount)
        isEmailVerified = try values.decodeIfPresent(Bool.self, forKey: .isEmailVerified)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        loginFirst = try values.decodeIfPresent(Bool.self, forKey: .loginFirst)
        pronouns = try values.decodeIfPresent(String.self, forKey: .pronouns)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
    }
    
    
}
