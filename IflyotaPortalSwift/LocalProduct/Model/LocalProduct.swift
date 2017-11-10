//
//	LocalProduct.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LocalProduct : NSObject{

	var cAIID : String!
	var cAIsAuthenticate : String!
	var classificationIID : String!
	var count : Int!
	var couponList : String!
	var couponTotal : Int!
	var descriptionField : String!
	var goodSpecInfo : String!
	var imgUrl : String!
	var imgs : String!
	var introduce : String!
	var minPrice : String!
	var orderIID : String!
	var originalPrice : Int!
	var params : String!
	var recommendSpecialtys : String!
	var salesNum : Int!
	var services : String!
	var shoppingCartIID : String!
	var specialtyIID : String!
	var specialtyName : String!
	var storeIID : String!
	var storeName : String!
	var subHead : String!
	var unitOfMeasure : String!
	var useInstructions : String!
	var userCommentList : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		cAIID = json["CAIID"].stringValue
		cAIsAuthenticate = json["CAIsAuthenticate"].stringValue
		classificationIID = json["ClassificationIID"].stringValue
		count = json["Count"].intValue
		couponList = json["CouponList"].stringValue
		couponTotal = json["CouponTotal"].intValue
		descriptionField = json["Description"].stringValue
		goodSpecInfo = json["GoodSpecInfo"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		imgs = json["Imgs"].stringValue
		introduce = json["Introduce"].stringValue
		minPrice = json["MinPrice"].stringValue
		orderIID = json["OrderIID"].stringValue
		originalPrice = json["OriginalPrice"].intValue
		params = json["Params"].stringValue
		recommendSpecialtys = json["RecommendSpecialtys"].stringValue
		salesNum = json["SalesNum"].intValue
		services = json["Services"].stringValue
		shoppingCartIID = json["ShoppingCartIID"].stringValue
		specialtyIID = json["SpecialtyIID"].stringValue
		specialtyName = json["SpecialtyName"].stringValue
		storeIID = json["StoreIID"].stringValue
		storeName = json["StoreName"].stringValue
		subHead = json["SubHead"].stringValue
		unitOfMeasure = json["UnitOfMeasure"].stringValue
		useInstructions = json["UseInstructions"].stringValue
		userCommentList = json["UserCommentList"].stringValue
	}
}
