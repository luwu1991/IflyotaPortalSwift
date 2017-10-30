//
//	Hotel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Hotel : NSObject{

	var address : String!
	var characteristicServiceAndRelationList : [String]!
	var couponTotal : Int!
	var distance : Int!
	var hType : String!
	var hotelDetailUrl : String!
	var hotelIID : String!
	var hotelName : String!
	var hotelRoomList : String!
	var imgUrl : String!
	var position : String!
	var priceRange : String!
	var stars : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		address = json["Address"].stringValue
		characteristicServiceAndRelationList = [String]()
		let characteristicServiceAndRelationListArray = json["CharacteristicServiceAndRelationList"].arrayValue
		for characteristicServiceAndRelationListJson in characteristicServiceAndRelationListArray{
			characteristicServiceAndRelationList.append(characteristicServiceAndRelationListJson.stringValue)
		}
		couponTotal = json["CouponTotal"].intValue
		distance = json["Distance"].intValue
		hType = json["HType"].stringValue
		hotelDetailUrl = json["HotelDetailUrl"].stringValue
		hotelIID = json["HotelIID"].stringValue
		hotelName = json["HotelName"].stringValue
		hotelRoomList = json["HotelRoomList"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		position = json["Position"].stringValue
		priceRange = json["PriceRange"].stringValue
		stars = json["Stars"].stringValue
	}

}
