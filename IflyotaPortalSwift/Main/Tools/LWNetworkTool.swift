
//
//  LWNetworkTool.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/18.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON


class LWNetworkTool: NSObject {
    //单例
    static let shareNetworkTool = LWNetworkTool()
    
    func loadHomePageBanner(pageName:String="首页",moduleName:String="顶部",finished:@escaping (_ items:[HomePageBannel]) -> ()) {
        let url = BASE_URL + "GetRollChartListByPageName"
        let params = ["pageName":pageName,"moduleName":moduleName]
        Alamofire.request(url,method:HTTPMethod.post,parameters:params)
                .responseJSON{ (responese) in
                    guard responese.result.isSuccess else{
                        SVProgressHUD.showError(withStatus: "加载失败...")
                        return
                    }
                    if let value = responese.result.value{
                        let dict = JSON(value)
                        let message = dict["m"].stringValue
                        guard dict["r"] == true else{
                            SVProgressHUD.showError(withStatus: message)
                            return
                        }
                        
                        
                        if let items = dict["c"].arrayObject{
                            var bannelItems = [HomePageBannel]()
                            for item in items{
                                let bannelItem = HomePageBannel (fromJson: JSON(item))
                                bannelItems.append(bannelItem)
                            }
                            finished(bannelItems)
                        }
                    }
        }
    }
    
    func loadHomePageNews(page:Int = 1,rows:Int = 5,finished:@escaping (_ items:[HomePageNew]) -> ()) {
        let url = BASE_URL + "GetInformationList"
        let params = ["page":page,"rows":rows]
        Alamofire.request(url,method:HTTPMethod.post,parameters:params)
            .responseJSON{ (responese) in
                guard responese.result.isSuccess else{
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                
                if let value = responese.result.value{
                    let dict = JSON(value)
                    if let items = dict["rows"].arrayObject{
                        var bannelItems = [HomePageNew]()
                        for item in items{
                            let bannelItem = HomePageNew (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    
}
