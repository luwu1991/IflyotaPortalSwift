//
//	LocalProductClassic.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class LocalProductClassic : NSObject{

	var createTime : String!
	var descriptionField : String!
	var iID : String!
	var name : String!
	var operation : String!
	var parentIID : String!
	var productNum : Int!
	var resourceUrl : String!
	var show : String!
	var sort : Int!
	var virtualPath : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createTime = json["CreateTime"].stringValue
		descriptionField = json["Description"].stringValue
		iID = json["IID"].stringValue
		name = json["Name"].stringValue
		operation = json["Operation"].stringValue
		parentIID = json["ParentIID"].stringValue
		productNum = json["ProductNum"].intValue
		resourceUrl = json["ResourceUrl"].stringValue
		show = json["Show"].stringValue
		sort = json["Sort"].intValue
		virtualPath = json["VirtualPath"].stringValue
	}

}
