
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
    
    func loadScenicSpot(sort:String="SSSort",resourceType:String="首页背景(app)",top:Int=8,finished:@escaping (_ items:[ScenicSpotModel]) -> ()){
        let url = BASE_URL + "GetScenicSpotByTop"
        let params = ["sort":sort,"resourceType":resourceType,"top":top] as [String:Any]
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
                        var bannelItems = [ScenicSpotModel]()
                        for item in items{
                            let bannelItem = ScenicSpotModel (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    /*
    groupName
    groupPage    首页
    groupModule    线路
    groupType
    imgType
    */
    func loadHomePageTags(finished:@escaping (_ items:[TagModel]) -> ()) {
        let url = BASE_URL + "GetTagsByCondition"
        let params = ["groupName":"","groupPage":"首页","groupModule":"线路","groupType":"","imgType":""]
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
                        var bannelItems = [TagModel]()
                        for item in items{
                            let bannelItem = TagModel(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    /*
     page    1
     rows    5
     sort    LIRecommendNumber
     order    desc
     selectTagNum    1
     condition    户外游
     */
    func loadHomePageLineList(condition:String,finished:@escaping (_ items:[LineListItemModel]) -> ())  {
       let url = BASE_URL + "GetLineListForIndex"
        let params = ["page":1,"rows":5,"sort":"LIRecommendNumber","order":"desc","selectTagNum":1,"condition":condition] as [String:Any]
        Alamofire.request(url,method:HTTPMethod.post,parameters:params)
            .responseJSON{ (responese) in
                guard responese.result.isSuccess else{
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = responese.result.value{
                    let dict = JSON(value)
                    let message = dict["err"].stringValue
                    guard message == "" else{
                        SVProgressHUD.showError(withStatus: message)
                        return
                    }
                    
                    
                    if let items = dict["rows"].arrayObject{
                        var bannelItems = [LineListItemModel]()
                        for item in items{
                            let bannelItem = LineListItemModel(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
        
    }
    /*
     pageName    酒店
     moduleName    顶部
     */
    func loadRollChartList(pageName:String,moduleName:String,finished:@escaping (_ items:[HomePageBannel]) -> ()){
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
    
}
