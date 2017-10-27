//
//	SearchHotelTags.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class SearchHotelTags : NSObject{

	var groupIID : String!
	var groupName : String!
	var imageUrl : String!
	var tags : [SearchHotelTag]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		groupIID = json["GroupIID"].stringValue
		groupName = json["GroupName"].stringValue
		imageUrl = json["ImageUrl"].stringValue
		tags = [SearchHotelTag]()
		let tagsArray = json["Tags"].arrayValue
		for tagsJson in tagsArray{
			let value = SearchHotelTag(fromJson: tagsJson)
			tags.append(value)
		}
	}

}
