//
//	Route.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Route : NSObject{

	var couponTotal : Int!
	var imgUrl : String!
	var lIIID : String!
	var lIName : String!
	var lISubhead : String!
	var lITripDays : String!
	var pLPrice : String!
	var scenicSpotsName : String!
	var tDescription : String!
	var tName : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		couponTotal = json["CouponTotal"].intValue
		imgUrl = json["ImgUrl"].stringValue
		lIIID = json["LIIID"].stringValue
		lIName = json["LIName"].stringValue
		lISubhead = json["LISubhead"].stringValue
		lITripDays = json["LITripDays"].stringValue
		pLPrice = json["PLPrice"].stringValue
		scenicSpotsName = json["ScenicSpotsName"].stringValue
		tDescription = json["TDescription"].stringValue
		tName = json["TName"].stringValue
	}
}
