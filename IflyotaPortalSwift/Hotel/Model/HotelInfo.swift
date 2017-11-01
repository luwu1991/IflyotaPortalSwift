//
//	HotelInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


//
//    HotelDetail.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class HotelDetail : NSObject{
    
    var cAIID : String!
    var cAIsAuthenticate : String!
    var collectInfo : String!
    var couponList : [String]!
    var hotelInfo : HotelInfo!
    var hotelRoomList : [HotelRoom]!
    var imgUrl : String!
    var objResourceList : String!
    var hotelModel : Hotel!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        cAIID = json["CAIID"].stringValue
        cAIsAuthenticate = json["CAIsAuthenticate"].stringValue
        collectInfo = json["CollectInfo"].stringValue
        couponList = [String]()
        let couponListArray = json["CouponList"].arrayValue
        for couponListJson in couponListArray{
            couponList.append(couponListJson.stringValue)
        }
        let hotelInfoJson = json["HotelInfo"]
        if !hotelInfoJson.isEmpty{
            hotelInfo = HotelInfo(fromJson: hotelInfoJson)
        }
        hotelRoomList = [HotelRoom]()
        let hotelRoomListArray = json["HotelRoomList"].arrayValue
        for hotelRoomListJson in hotelRoomListArray{
            let value = HotelRoom(fromJson: hotelRoomListJson)
            hotelRoomList.append(value)
        }
        imgUrl = json["ImgUrl"].stringValue
        objResourceList = json["ObjResourceList"].stringValue
        let hotelModelJson = json["hotelModel"]
        if !hotelModelJson.isEmpty{
            hotelModel = Hotel(fromJson: hotelModelJson)
        }
    }
    
    
    
}

class HotelInfo : NSObject{

	var cAIID : String!
	var cAIsAuthenticate : String!
	var couponTotal : Int!
	var distance : Int!
	var hAddress : String!
	var hCreateTime : String!
	var hDescription : String!
	var hIID : String!
	var hIllustration : String!
	var hIntroduce : String!
	var hKeyWord : String!
	var hLevel : String!
	var hName : String!
	var hNeighboringMerchant : String!
	var hPart : String!
	var hPay : String!
	var hPhone : String!
	var hPosition : String!
	var hRecommendedOrder : Int!
	var hRoomCount : Int!
	var hService : String!
	var hStartBusinessTime : String!
	var hStatus : String!
	var hTraffic : String!
	var hType : String!
	var imgUrl : String!
	var minPrice : Int!
	var resourceUrl : String!
	var x : String!
	var y : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		cAIID = json["CAIID"].stringValue
		cAIsAuthenticate = json["CAIsAuthenticate"].stringValue
		couponTotal = json["CouponTotal"].intValue
		distance = json["Distance"].intValue
		hAddress = json["HAddress"].stringValue
		hCreateTime = json["HCreateTime"].stringValue
		hDescription = json["HDescription"].stringValue
		hIID = json["HIID"].stringValue
		hIllustration = json["HIllustration"].stringValue
		hIntroduce = json["HIntroduce"].stringValue
		hKeyWord = json["HKeyWord"].stringValue
		hLevel = json["HLevel"].stringValue
		hName = json["HName"].stringValue
		hNeighboringMerchant = json["HNeighboringMerchant"].stringValue
		hPart = json["HPart"].stringValue
		hPay = json["HPay"].stringValue
		hPhone = json["HPhone"].stringValue
		hPosition = json["HPosition"].stringValue
		hRecommendedOrder = json["HRecommendedOrder"].intValue
		hRoomCount = json["HRoomCount"].intValue
		hService = json["HService"].stringValue
		hStartBusinessTime = json["HStartBusinessTime"].stringValue
		hStatus = json["HStatus"].stringValue
		hTraffic = json["HTraffic"].stringValue
		hType = json["HType"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		minPrice = json["MinPrice"].intValue
		resourceUrl = json["ResourceUrl"].stringValue
		x = json["X"].stringValue
		y = json["Y"].stringValue
	}

}
