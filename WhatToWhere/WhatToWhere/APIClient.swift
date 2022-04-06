//
//  APIClient.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 04/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient : NSObject {
    
    struct API {
        static let baseURL              = ApiConstants.kBaseURL
        static let signin               = "user/SignInUser"
        static let signup               = "user/SignUpUser"
        static let verificationCode     = "user/GetVerificationCodeByEmailForSignUp"
        static let forgotPassword       = "user/ForgotPassword"
        static let userDetail           = "user/GetUserDataByUserId"
        static let changePassword       = "user/ResetPassword"
        static let logOut               = "user/SignOutUse"
        static let followersList        = "follow/GetFollowerList"
        static let followingsList       = "follow/GetFollowingList"
        static let removeFollowers      = "follow/RemoveFollower"
        static let editProfile          = "user/EditUserProfile"
    }
    
    enum Parameters {
        case signin(email_id : String, password : String , loginType : String, firebaseToken : String , deviceType : String)
        case signup(email_id : String, userName : String, password : String , loginType : String, firebaseToken : String , deviceType : String, isEmailVefied : Bool , profilePicture : String )
        case forgotPassword(user_id : String, password : String)
        case changePassword(user_id : String, oldPassword : String, newPassword : String)
        case editProfile(user_id : String, userName : String, gender : String, description : String, pronounse : String, mobileNumber : String, dob : String)
        
        func getParams()->[String:Any] {
            switch self {
            case .signin(let email_id, let password, let loginType, let firebaseToken, let deviceType):
                return ["Email" :email_id,
                        "Password" : password,
                        "LoginType" : loginType,
                        "FirebaseToken" : firebaseToken,
                        "DeviceType" : deviceType]
            case .signup(let email_id, let userName, let password, let loginType, let firebaseToken, let deviceType, let isEmailVefied, let profilePicture):
                return ["Email" :email_id,
                        "UserName" : userName,
                        "Password" : password,
                        "LoginType" : loginType,
                        "FirebaseToken" : firebaseToken,
                        "DeviceType" : deviceType,
                        "IsEmailVerified" : isEmailVefied,
                        "ProfileImage" : profilePicture]
            case .forgotPassword(let user_id, let password):
                return ["UserId" : user_id,
                        "Password" : password]
            case .changePassword(let user_id, let oldPassword, let newPassword):
                return ["UserId":user_id,
                        "OldPassword":oldPassword,
                        "Newpassword":newPassword]
            case .editProfile(let user_id, let userName, let gender, let description, let pronounse, let mobileNumber, let dob):
                return ["UserId": user_id,
                        "UserName": userName,
                        "Gender": gender,
                        "Description": description,
                        "Pronouns": pronounse,
                        "Mobile": mobileNumber,
                        "DOB": dob]
            }
        }
    }
    
    internal typealias CompletionBlock = (_ data:[String:Any]?,_ responseCode:Int? ,_ error:NSError?) -> Void

    func executePostAPICallWithMethod(apiName:String, params:[String:Any] , callback:@escaping CompletionBlock) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        print("API: " , apiName)
        print("Params: ", params)
        
        AF.request(API.baseURL+apiName, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case .success(let JSON) :
                callback(JSON as? [String : Any],response.response?.statusCode,nil)
            case .failure(let error) :
                callback(nil,response.response?.statusCode,error as NSError?)
            }
        }.responseString { response in
            //print("executePostAPICallWithMethod Response String: \(String(describing: response.result.value)) for Method : \(method) with paramater \(parameters)")
            print("RequestResponse:: ",response.value ?? AnyObject.self)
        }
    }

    func executePostAPICallWithHeaderMethod(apiName:String, params:[String:Any] , callback:@escaping CompletionBlock) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(NSUtils.sharedInstance.getValuefromUserDefault(keyParameter: LoginUser.AccessToken) ?? "")",
        ]

        print("API: " , apiName)
        print("Params: ", params)
        
        AF.request(API.baseURL+apiName, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case .success(let JSON) :
                callback(JSON as? [String : Any],response.response?.statusCode,nil)
            case .failure(let error) :
                callback(nil,response.response?.statusCode,error as NSError?)
            }
        }.responseString { response in
            //print("executePostAPICallWithMethod Response String: \(String(describing: response.result.value)) for Method : \(method) with paramater \(parameters)")
            print("RequestResponse:: ",response.value ?? AnyObject.self)
        }
    }

    func executeGetAPICallWithMethod(apiName:String, callback:@escaping CompletionBlock) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        print("API: " , apiName)
        
        AF.request(API.baseURL+apiName, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch response.result {
            case .success(let JSON) :
                callback(JSON as? [String : Any],response.response?.statusCode,nil)
            case .failure(let error) :
                callback(nil,response.response?.statusCode,error as NSError?)
            }
        }.responseString { response in
            //print("executePostAPICallWithMethod Response String: \(String(describing: response.result.value)) for Method : \(method) with paramater \(parameters)")
            print("RequestResponse:: ",response.value ?? AnyObject.self)
        }
    }

    func executeUploadAPICallWithHeaderMethod(apiName:String, arrFile: [Dictionary<String, Any>], params:[String:Any] , callback:@escaping CompletionBlock) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if arrFile.count > 0 {
                for i in 0..<arrFile.count {
//                    let dictTemp : NSMutableDictionary = arrFile[i]["imageData"]
                    let imageData : Data = (arrFile[i]["imageData"] as? Data)!
                    let name : String = (arrFile[i]["name"] as? String)!
                    let fileName : String = (arrFile[i]["fileName"] as? String)!
                    let mimeType : String = (arrFile[i]["mimeType"] as? String)!
                    multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
                }
            }
        }, to: API.baseURL+apiName, method: .post, headers: header)
        .uploadProgress(queue: .main) { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseJSON { response in
            switch response.result {
            case .success(let JSON):
                DispatchQueue.main.async {
                    callback(JSON as? [String : Any],response.response?.statusCode,nil)
                }
                break
            case .failure(let error):
                callback(nil,response.response?.statusCode,error as NSError?)
                break
            }
        
    }
        
    }

}
