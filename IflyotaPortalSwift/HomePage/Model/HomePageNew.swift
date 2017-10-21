//
//	HomePageNew.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class HomePageNew : NSObject{

	var contentAPP : String!
	var contentWeb : String!
	var createAccount : String!
	var createTime : String!
	var iID : String!
	var imgUrl : String!
	var introduce : String!
	var recommendedOrder : Int!
	var reserve1 : String!
	var reserve2 : String!
	var reserve3 : String!
	var reserve4 : String!
	var source : String!
	var stauts : String!
	var title : String!
	var type : String!
	var uRL : String!
	var updateAccount : String!
	var updateTime : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		contentAPP = json["ContentAPP"].stringValue
		contentWeb = json["ContentWeb"].stringValue
		createAccount = json["CreateAccount"].stringValue
		createTime = json["CreateTime"].stringValue
		iID = json["IID"].stringValue
		imgUrl = json["ImgUrl"].stringValue
		introduce = json["Introduce"].stringValue
		recommendedOrder = json["RecommendedOrder"].intValue
		reserve1 = json["Reserve1"].stringValue
		reserve2 = json["Reserve2"].stringValue
		reserve3 = json["Reserve3"].stringValue
		reserve4 = json["Reserve4"].stringValue
		source = json["Source"].stringValue
		stauts = json["Stauts"].stringValue
		title = json["Title"].stringValue
		type = json["Type"].stringValue
		uRL = json["URL"].stringValue
		updateAccount = json["UpdateAccount"].stringValue
		updateTime = json["UpdateTime"].stringValue
	}


}
