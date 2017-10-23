//
//	ScenicSpotModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ScenicSpotModel : NSObject{

	var address : String!
	var bookTicketUrl : String!
	var cAIID : String!
	var cAIsAuthenticate : String!
	var characteristic : String!
	var couponDetail : String!
	var couponTotal : String!
	var descriptionField : String!
	var imgUrl : String!
	var introduce : String!
	var level : String!
	var notes : String!
	var openTime : String!
	var productModelList : String!
	var scenicIID : String!
	var scenicName : String!
	var scenicSpotDetail : String!
	var scenicTicketPriceRange : String!
	var subhead : String!
	var tName : String!
	var themes : String!
	var themesList : String!
	var truncationSubhead : String!
	var weather : String!

    
	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		address = json["Address"].stringValue
		bookTicketUrl = json["BookTicketUrl"].stringValue
		cAIID = json["CAIID"].stringValue
		cAIsAuthenticate = json["CAIsAuthenticate"].stringValue
		characteristic = json["Characteristic"].stringValue
		couponDetail = json["CouponDetail"].stringValue
		couponTotal = json["CouponTotal"].stringValue
		descriptionField = json["Description"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		introduce = json["Introduce"].stringValue
		level = json["Level"].stringValue
		notes = json["Notes"].stringValue
		openTime = json["OpenTime"].stringValue
		productModelList = json["ProductModelList"].stringValue
		scenicIID = json["ScenicIID"].stringValue
		scenicName = json["ScenicName"].stringValue
		scenicSpotDetail = json["ScenicSpotDetail"].stringValue
		scenicTicketPriceRange = json["ScenicTicketPriceRange"].stringValue
		subhead = json["Subhead"].stringValue
		tName = json["TName"].stringValue
		themes = json["Themes"].stringValue
		themesList = json["ThemesList"].stringValue
		truncationSubhead = json["TruncationSubhead"].stringValue
		weather = json["weather"].stringValue
	}

	
	

}
