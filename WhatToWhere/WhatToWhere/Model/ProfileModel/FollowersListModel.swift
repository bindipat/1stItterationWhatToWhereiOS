//
//  FollowersListModel.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 25/03/22.
//

import Foundation
import SwiftyJSON

struct FollowersListResponseModel: Codable {
    let message: String?
    let issuccess: Bool?
    let data: [FollowersListDataModel]?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case issuccess = "issuccess"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        data = try values.decodeIfPresent([FollowersListDataModel].self, forKey: .data)
    }

}

// MARK: - Login
struct FollowersListDataModel: Codable {
    let followerID: Int?
    let userName, email, profileImage: String?
    let isFollowing: Bool?

    enum CodingKeys: String, CodingKey {
        case followerID = "FollowerId"
        case userName = "UserName"
        case email = "Email"
        case profileImage = "ProfileImage"
        case isFollowing = "isFollowing"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        followerID = try values.decodeIfPresent(Int.self, forKey: .followerID)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        isFollowing = try values.decodeIfPresent(Bool.self, forKey: .isFollowing)
    }
    
}
