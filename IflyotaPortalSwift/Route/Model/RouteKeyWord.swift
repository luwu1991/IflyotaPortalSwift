//
//	RouteKeyWord.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RouteKeyWord : NSObject{

	var iID : String!
	var keyword : String!
	var searchNum : Int!
	var sort : Int!
	var type : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		iID = json["IID"].stringValue
		keyword = json["Keyword"].stringValue
		searchNum = json["SearchNum"].intValue
		sort = json["Sort"].intValue
		type = json["Type"].stringValue
	}
}
