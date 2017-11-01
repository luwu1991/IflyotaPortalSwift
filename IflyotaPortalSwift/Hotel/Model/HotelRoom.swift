//
//	HotelRoomInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class HotelRoom : NSObject{
    
    var hRImgURL : String!
    var hotelRoomInfo : HotelRoomInfo!
    var illustration : String!
    var level : String!
    var price : HotelPrice!
    var status : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        hRImgURL = json["HRImgURL"].stringValue
        let hotelRoomInfoJson = json["HotelRoomInfo"]
        if !hotelRoomInfoJson.isEmpty{
            hotelRoomInfo = HotelRoomInfo(fromJson: hotelRoomInfoJson)
        }
        illustration = json["Illustration"].stringValue
        level = json["Level"].stringValue
        let priceJson = json["Price"]
        if !priceJson.isEmpty{
            price = HotelPrice(fromJson: priceJson)
        }
        status = json["Status"].intValue
    }
    
    
}

class HotelPrice : NSObject{
    
    var cashBack : Int!
    var name : String!
    var pLAgreementPrice : Int!
    var pLEndDate : String!
    var pLGoodsType : String!
    var pLIID : String!
    var pLInventory : Int!
    var pLMIID : String!
    var pLName : String!
    var pLPrice : Int!
    var pLStartDate : String!
    var pLStatus : String!
    var pLType : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        cashBack = json["CashBack"].intValue
        name = json["Name"].stringValue
        pLAgreementPrice = json["PLAgreementPrice"].intValue
        pLEndDate = json["PLEndDate"].stringValue
        pLGoodsType = json["PLGoodsType"].stringValue
        pLIID = json["PLIID"].stringValue
        pLInventory = json["PLInventory"].intValue
        pLMIID = json["PLMIID"].stringValue
        pLName = json["PLName"].stringValue
        pLPrice = json["PLPrice"].intValue
        pLStartDate = json["PLStartDate"].stringValue
        pLStatus = json["PLStatus"].stringValue
        pLType = json["PLType"].stringValue
    }
    
    
}

class HotelRoomInfo : NSObject{

	var couponTotal : Int!
	var hIID : String!
	var hName : String!
	var hRAcreage : String!
	var hRAgreementPrice : Float!
	var hRBedType : String!
	var hRBreakfast : String!
	var hRFacilities : String!
	var hRFloor : String!
	var hRIID : String!
	var hRMaximumOccupancy : String!
	var hRName : String!
	var hRNetwork : String!
	var hRNumber : Int!
	var hROther : String!
	var hRPrice : Double!
	var hRReserved1 : String!
	var hRReserved2 : String!
	var hRReserved3 : String!
	var hRReserved4 : String!
	var hRReserved5 : String!
	var hRReserved6 : String!
	var hRStatus : String!
	var hRType : String!
	var imgUrl : String!
	var resourceUrl : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		couponTotal = json["CouponTotal"].intValue
		hIID = json["HIID"].stringValue
		hName = json["HName"].stringValue
		hRAcreage = json["HRAcreage"].stringValue
		hRAgreementPrice = json["HRAgreementPrice"].floatValue
		hRBedType = json["HRBedType"].stringValue
		hRBreakfast = json["HRBreakfast"].stringValue
		hRFacilities = json["HRFacilities"].stringValue
		hRFloor = json["HRFloor"].stringValue
		hRIID = json["HRIID"].stringValue
		hRMaximumOccupancy = json["HRMaximumOccupancy"].stringValue
		hRName = json["HRName"].stringValue
		hRNetwork = json["HRNetwork"].stringValue
		hRNumber = json["HRNumber"].intValue
		hROther = json["HROther"].stringValue
		hRPrice = json["HRPrice"].doubleValue
		hRReserved1 = json["HRReserved1"].stringValue
		hRReserved2 = json["HRReserved2"].stringValue
		hRReserved3 = json["HRReserved3"].stringValue
		hRReserved4 = json["HRReserved4"].stringValue
		hRReserved5 = json["HRReserved5"].stringValue
		hRReserved6 = json["HRReserved6"].stringValue
		hRStatus = json["HRStatus"].stringValue
		hRType = json["HRType"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		resourceUrl = json["ResourceUrl"].stringValue
	}

}
