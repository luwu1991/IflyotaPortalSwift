//
//	ScenicSpotDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ScenicSpotDetail : NSObject{

	var imgResourceName : String!
	var imgResourceUrl : String!
	var imgType : String!
	var address : String!
	var bookTicketUrl : String!
	var cAIID : String!
	var cAIsAuthenticate : String!
	var characteristic : String!
	var couponDetail : [String]!
	var couponTotal : String!
	var descriptionField : String!
	var imgUrl : String!
	var introduce : String!
	var level : String!
	var notes : String!
	var openTime : String!
	var productModelList : [ProductModelList]!
	var scenicIID : String!
	var scenicName : String!
	var scenicSpotDetail : [ScenicSpotDetail]!
	var scenicTicketPriceRange : String!
	var subhead : String!
	var tName : String!
	var themes : String!
	var themesList : [String]!
	var truncationSubhead : String!
	var weather : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		imgResourceName = json["ImgResourceName"].stringValue
		imgResourceUrl = json["ImgResourceUrl"].stringValue
		imgType = json["ImgType"].stringValue
		address = json["Address"].stringValue
		bookTicketUrl = json["BookTicketUrl"].stringValue
		cAIID = json["CAIID"].stringValue
		cAIsAuthenticate = json["CAIsAuthenticate"].stringValue
		characteristic = json["Characteristic"].stringValue
		couponDetail = [String]()
		let couponDetailArray = json["CouponDetail"].arrayValue
		for couponDetailJson in couponDetailArray{
			couponDetail.append(couponDetailJson.stringValue)
		}
		couponTotal = json["CouponTotal"].stringValue
		descriptionField = json["Description"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		introduce = json["Introduce"].stringValue
		level = json["Level"].stringValue
		notes = json["Notes"].stringValue
		openTime = json["OpenTime"].stringValue
		productModelList = [ProductModelList]()
		let productModelListArray = json["ProductModelList"].arrayValue
		for productModelListJson in productModelListArray{
			let value = ProductModelList(fromJson: productModelListJson)
			productModelList.append(value)
		}
		scenicIID = json["ScenicIID"].stringValue
		scenicName = json["ScenicName"].stringValue
		scenicSpotDetail = [ScenicSpotDetail]()
		let scenicSpotDetailArray = json["ScenicSpotDetail"].arrayValue
		for scenicSpotDetailJson in scenicSpotDetailArray{
			let value = ScenicSpotDetail(fromJson: scenicSpotDetailJson)
			scenicSpotDetail.append(value)
		}
		scenicTicketPriceRange = json["ScenicTicketPriceRange"].stringValue
		subhead = json["Subhead"].stringValue
		tName = json["TName"].stringValue
		themes = json["Themes"].stringValue
		themesList = [String]()
		let themesListArray = json["ThemesList"].arrayValue
		for themesListJson in themesListArray{
			themesList.append(themesListJson.stringValue)
		}
		truncationSubhead = json["TruncationSubhead"].stringValue
		weather = json["weather"].stringValue
	}

}

class ProductModelList : NSObject{
    
    var code : String!
    var couponTotal : Int!
    var descriptionField : String!
    var iID : String!
    var illustration : String!
    var imgUrl : String!
    var level : String!
    var name : String!
    var objResourceList : String!
    var parentIID : String!
    var parentName : String!
    var parentType : String!
    var price : String!
    var priceLists : [PriceList]!
    var type : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["Code"].stringValue
        couponTotal = json["CouponTotal"].intValue
        descriptionField = json["Description"].stringValue
        iID = json["IID"].stringValue
        illustration = json["Illustration"].stringValue
        imgUrl = json["ImgUrl"].stringValue
        level = json["Level"].stringValue
        name = json["Name"].stringValue
        objResourceList = json["ObjResourceList"].stringValue
        parentIID = json["ParentIID"].stringValue
        parentName = json["ParentName"].stringValue
        parentType = json["ParentType"].stringValue
        price = json["Price"].stringValue
        priceLists = [PriceList]()
        let priceListsArray = json["PriceLists"].arrayValue
        for priceListsJson in priceListsArray{
            let value = PriceList(fromJson: priceListsJson)
            priceLists.append(value)
        }
        type = json["Type"].stringValue
    }
    
}

class PriceList : NSObject{
    
    var cashBack : Double!
    var name : String!
    var pLAgreementPrice : Float!
    var pLEndDate : String!
    var pLGoodsType : String!
    var pLIID : String!
    var pLInventory : Int!
    var pLMIID : String!
    var pLName : String!
    var pLPrice : Float!
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
        cashBack = json["CashBack"].doubleValue
        name = json["Name"].stringValue
        pLAgreementPrice = json["PLAgreementPrice"].floatValue
        pLEndDate = json["PLEndDate"].stringValue
        pLGoodsType = json["PLGoodsType"].stringValue
        pLIID = json["PLIID"].stringValue
        pLInventory = json["PLInventory"].intValue
        pLMIID = json["PLMIID"].stringValue
        pLName = json["PLName"].stringValue
        pLPrice = json["PLPrice"].floatValue
        pLStartDate = json["PLStartDate"].stringValue
        pLStatus = json["PLStatus"].stringValue
        pLType = json["PLType"].stringValue
    }
}
