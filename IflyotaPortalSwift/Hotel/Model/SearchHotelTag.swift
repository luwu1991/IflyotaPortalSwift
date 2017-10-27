//
//	Tag.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class SearchHotelTag : NSObject{

	var tColor : String!
	var tDescription : String!
	var tGroup : String!
	var tIID : String!
	var tName : String!
	var tType : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		tColor = json["TColor"].stringValue
		tDescription = json["TDescription"].stringValue
		tGroup = json["TGroup"].stringValue
		tIID = json["TIID"].stringValue
		tName = json["TName"].stringValue
		tType = json["TType"].stringValue
	}


}
