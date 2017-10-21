//
//  HomePageBannel.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/18.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
class HomePageBannel: NSObject {
        var configCode : String!
        var configStatus : String!
        var configType : String!
        var createTime : String!
        var createUser : String!
        var iID : String!
        var imgUrl : String!
        var pageName : String!
        var platformType : String!
        var remark : String!
        var reserve1 : String!
        var reserve2 : String!
        var reserve3 : String!
        var resourceUrl : String!
        var skipUrl : String!
        var sortNumber : Int!
        var virtualPath : String!
        
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json.isEmpty{
                return
            }
            configCode = json["ConfigCode"].stringValue
            configStatus = json["ConfigStatus"].stringValue
            configType = json["ConfigType"].stringValue
            createTime = json["CreateTime"].stringValue
            createUser = json["CreateUser"].stringValue
            iID = json["IID"].stringValue
            imgUrl = json["ImgUrl"].stringValue
            pageName = json["PageName"].stringValue
            platformType = json["PlatformType"].stringValue
            remark = json["Remark"].stringValue
            reserve1 = json["Reserve1"].stringValue
            reserve2 = json["Reserve2"].stringValue
            reserve3 = json["Reserve3"].stringValue
            resourceUrl = json["ResourceUrl"].stringValue
            skipUrl = json["SkipUrl"].stringValue
            sortNumber = json["SortNumber"].intValue
            virtualPath = json["VirtualPath"].stringValue
        }
        
    
        
}

