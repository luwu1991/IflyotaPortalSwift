
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
    func loadHomePageLineList(condition:String,finished:@escaping (_ items:[Route]) -> ())  {
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
                        var bannelItems = [Route]()
                        for item in items{
                            let bannelItem = Route(fromJson: JSON(item))
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
    /*
     groupNames
     groupChannel    安卓客户端
     groupPages    酒店搜索
     groupModules    搜索
     groupTypes    酒店
     imgType
     */
 func loadHotelTagGroup(groupNames:String,groupChannel:String,groupPages:String,groupModules:String,groupTypes:String,imgType:String,finished:@escaping (_ items:[SearchHotelTags]) -> ()){
        let url = BASE_URL + "GetImgGroupTagList"
        let params = ["groupNames":groupNames,"groupChannel":groupChannel,"groupPages":groupPages,"groupModules":groupModules,"groupTypes":groupTypes,"imgType":imgType]
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
                        var bannelItems = [SearchHotelTags]()
                        for item in items{
                            let bannelItem = SearchHotelTags (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    /*
     {
     "dicRecord": {
     "UserIID": "",
     "ObjectIID": "",
     "ObjectType": "酒店",
     "OperateCentent": "黄山",
     "Reserve1": ""
     },
     "ajax": "jquery1.4.2"
     }
     */
    func addHistoryRecord(ObjectType:String,OperateCentent:String,UserIID:String){
        let url = BASE_URL + "AddHistoryRecord"
        var dic = Dictionary<String,String>()
        dic["UserIID"] = UserIID
        dic["ObjectIID"] = ""
        dic["ObjectType"] = ObjectType
        dic["OperateCentent"] = OperateCentent
        dic["Reserve1"] = ""
        let params = ["dicRecord":dic,"ajax":"jquery1.4.2"] as [String:Any]
        Alamofire.request(url,method:.post,parameters:params,encoding: JSONEncoding(options: []))
            .responseJSON{ (responese) in
                
                if let value = responese.result.value{
                    let dict = JSON(value)
                    guard dict["r"] == true else{
                        return
                    }
                    let userID = dict["c"].rawString()
                    UserInfo.shareUserInfo.userID = userID
                }
        }
        
     }
    
    func loadHistoryRecords(userID:String,type:String,finished:@escaping (_ items:[HistoryRecord]) -> ()){
        let url = BASE_URL + "GetHistoryRecordsByUser"
        let params = ["iid":userID,"type":type]
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
                        var bannelItems = [HistoryRecord]()
                        for item in items{
                            let bannelItem = HistoryRecord (fromJson: JSON(item))
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
     sort    HRecommendedOrder
     order    desc
     beginDate    2017-10-31
     endDate     2017-11-01
     condition    黄山北站
     tagNum    1
     keyWord    黄山北站
     imgType    列表背景(app)
     level    名宿客栈
     minPrice
     maxPrice    1700
     x    0
     y    0
     */
    func searchHotelList(page:Int,rows:Int,beginDate:String,endDate:String,keyWord:String,level:String,minPrice:String,maxPrice:String,sort: String = "HRecommendedOrder",finished:@escaping (_ total:Int,_ items:[Hotel]) -> ()){
        let url = BASE_URL + "GetHotelListByTagAndImgTypeAndCoordinates"
        var order = "desc"
        var newSort = sort
        if sort == "MaxPrice" {
            newSort = "MinPrice"
            order = "asc"
        }
        let params = ["page":page,"rows":rows,"sort":newSort,"order":order,"beginDate":beginDate,"endDate":endDate,"condition":keyWord,"tagNum":1,"keyWord":keyWord,"imgType":"列表背景(app)","level":level,"minPrice":minPrice,"maxPrice":maxPrice,"x":0,"y":0] as [String:Any]
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
                        var bannelItems = [Hotel]()
                        for item in items{
                            let bannelItem = Hotel(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(dict["total"].intValue,bannelItems)
                    }
                }
        }
    }
    
    func loadHotelDetailWithIID(_ iid:String,startDate:String,endDate:String,finished:@escaping (_ hotelInfo:HotelInfo,_ items:[HotelRoom]) -> ()){
        let url = BASE_URL + "GetHotelDetailInfoWithCashBack"
        let params = ["iid":iid,"staTime":startDate,"endTime":endDate,"imgType":""]
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
                    
                    if let data = dict["c"].dictionaryObject {
                        let hotelDetail = HotelDetail (fromJson: JSON(data))
                        finished(hotelDetail.hotelInfo,hotelDetail.hotelRoomList)
                    }
                }
        }
    }
    /*
     page    1
     rows    5
     sort    LIRecommendNumber
     order    desc
     selectTagNum    0
     condition
     theme
     keyWord
     tripDay
     minPrice    0
     maxPrice    999999
     imgType
     */
    func loadRouteList(page:Int,rows:Int,keyWord:String,minPrice:String,maxPrice:String,theme:String,sort:String = "LIRecommendNumber",finished:@escaping (_ total:Int,_ items:[Route]) -> ()){
        let url = BASE_URL + "GetLineJoinTagPageList"
        var order = "desc"
        var newSort = sort
        if sort == "MaxPrice" {
            newSort = "MinPrice"
            order = "asc"
        }
        let params = ["page":page,"rows":rows,"sort":newSort,"order":order,"selectTagNum":0,"condition":theme,"theme":theme,"keyWord":keyWord,"tripDay":"","minPrice":minPrice ,"maxPrice":maxPrice ,"imgType":""] as [String : Any]
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
                        var bannelItems = [Route]()
                        for item in items{
                            let bannelItem = Route(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(dict["total"].intValue,bannelItems)
                    }
                }
        }
    }
    
    func loadKeyWordByType(type:String,finished:@escaping (_ items:[RouteKeyWord]) -> ()){
        let url = BASE_URL + "GetKeyWordByType"
        let params = ["type":type,"sort":"Sort"]
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
                        var bannelItems = [RouteKeyWord]()
                        for item in items{
                            let bannelItem = RouteKeyWord (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    
    func loadRouteDetailWith(iid:String,finished:@escaping (_ item:RouteDetail) -> ()){
        let url = BASE_URL + "GetLineDetail"
        let params = ["iid":iid,"tagName":"户外休闲"]
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
                    
                    
                    if let item = dict["c"].dictionary{
                        let routeDetail =  RouteDetail.init(fromJson: JSON(item))
                        finished(routeDetail)
                    }
                }
        }
    }
    
    
    func loadScenicSpotList(sort:String,page:Int,rows:Int,finished:@escaping (_ total:Int,_ items:[ScenicSpotModel]) -> ()){
        let url = BASE_URL + "GetScenicSpotsPageListByCoordinates"
        var order = "desc"
        var newSort = sort
        if sort == "MaxPrice" {
            newSort = "MinPrice"
            order = "desc"
        }else if (sort == "MinPrice"){
            newSort = "MinPrice"
             order = "asc"
        }
        let params = ["sort":newSort,"page":page,"rows":rows,"order":order,"imgType":"列表背景(app)","x":0,"y":0] as [String:Any]
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
                        var bannelItems = [ScenicSpotModel]()
                        for item in items{
                            let bannelItem = ScenicSpotModel(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(dict["total"].intValue,bannelItems)
                    }
                }
        }
    }
    
    /*
     GetSelectTagName
     */
    
    func loadSelectTagName(groupName:String,groupType:String,finished:@escaping (_ items:[TagModel]) -> ()){
        let url = BASE_URL + "GetSelectTagName"
        let params = ["groupName":groupName,"groupType":groupType,"channel":"安卓客户端"]
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
                            let bannelItem = TagModel (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    
    func loadScenicSpotDetailWith(_ iid:String,finished:@escaping (_ item:ScenicSpotDetail) -> ()){
        let url = BASE_URL + "GetScenicSpotDetailInfoBySSIID"
        let params = ["ssiid":iid]
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
                    
                    
                    if let item = dict["c"].dictionary{
                        let scenicSpotDetail =  ScenicSpotDetail.init(fromJson: JSON(item))
                        finished(scenicSpotDetail)
                    }
                }
        }
    }
    
    
    func loadSpecialtyLocalProduct(page:Int,rows:Int,sort:String,order:String,finished:@escaping (_ items:[LocalProduct]) -> ()){
        let url = BASE_URL + "GetSpecialtyListForIndex"
        let params = ["page":page,"rows":rows,"sort":sort,"order":order,"imgType":"首页背景(app)"] as [String : Any]
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
                        var bannelItems = [LocalProduct]()
                        for item in items{
                            let bannelItem = LocalProduct (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    
    
    func loadLocalproductClassic(finished:@escaping (_ items:[LocalProductClassic]) -> ()){
        let url = BASE_URL + "GetClassificationAndResourceList"
        let params = ["parentIID":"","imgType":"展示图(app)"]
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
                        var bannelItems = [LocalProductClassic]()
                        for item in items{
                            let bannelItem = LocalProductClassic (fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
    
    //GetSpecialtyListByClassification
    /*
     page    1
     rows    8
     sort    SRecommendedOrder
     order    desc
     classificationIID    E5B83BB7-4DC8-4A17-B9EC-6104FC6124C7
     keyWord
     minPrice
     maxPrice
     imgType    列表背景(app)
     */
    
    func loadLocalProductList(page:Int,rows:Int,sort:String,order:String,IID:String,keyWord:String,minPrice:String,maxPrice:String,finished:@escaping (_ items:[LocalProduct]) -> ()){
        let url = BASE_URL + "GetSpecialtyListByClassification"
        let params = ["page":page,"rows":rows,"sort":sort,"order":order,"classificationIID":IID,"keyWord":keyWord,"minPrice":minPrice,"maxPrice":maxPrice,"imgType":"列表背景(app)"] as [String : Any]
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
                        var bannelItems = [LocalProduct]()
                        for item in items{
                            let bannelItem = LocalProduct(fromJson: JSON(item))
                            bannelItems.append(bannelItem)
                        }
                        finished(bannelItems)
                    }
                }
        }
    }
}





