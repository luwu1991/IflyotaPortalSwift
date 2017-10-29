//
//  UserInfo.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/27.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    static let shareUserInfo = UserInfo()
    var userID:String?{
        didSet{
            UserDefaults.standard.set(userID, forKey: "UserID")
        }
    }
}
