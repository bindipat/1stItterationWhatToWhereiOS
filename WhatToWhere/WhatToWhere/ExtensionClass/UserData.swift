import Foundation
import UIKit

class UserData {
    static let preference = UserDefaults.standard
    
    static let UserId : String = LoginUser.UserId
    static let UserName : String = LoginUser.UserName
    static let Email : String = LoginUser.Email
    static let ProfileImage : String = LoginUser.ProfileImage
    static let LoginType : String = LoginUser.LoginType
    static let Description : String = LoginUser.Description
    static let FollowingCount : String = LoginUser.FollowingCount
    static let FollowerCount : String = LoginUser.FollowerCount
    
    static func setMemberSID(_ userID: String){
        preference.setValue(userID, forKey: UserId)
        preference.synchronize()
    }
    
    static func getMemberSID() -> String?{
        return preference.string(forKey: UserId)
    }
    
    //My User Id
    static func setUserName(_ userName: String){
        preference.setValue(userName, forKey: UserName)
        
        preference.synchronize()
    }
    
    static func getUserName() -> String?{
        return preference.string(forKey: UserName)
    }
    
    
    
    //XMPP Store File 
    
}
