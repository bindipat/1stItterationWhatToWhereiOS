//
//  FollowingsListModel.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 25/03/22.
//

import Foundation
import SwiftyJSON

struct FollowingsListResponseModel: Codable {
    let message: String?
    let issuccess: Bool?
    let data: [FollowingsListDataModel]?

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case issuccess = "issuccess"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        issuccess = try values.decodeIfPresent(Bool.self, forKey: .issuccess)
        data = try values.decodeIfPresent([FollowingsListDataModel].self, forKey: .data)
    }

}

// MARK: - Login
struct FollowingsListDataModel: Codable {
    let followingID: Int?
    let userName, email, profileImage: String?

    enum CodingKeys: String, CodingKey {
        case followingID = "FollowingId"
        case userName = "UserName"
        case email = "Email"
        case profileImage = "ProfileImage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        followingID = try values.decodeIfPresent(Int.self, forKey: .followingID)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
    
}
