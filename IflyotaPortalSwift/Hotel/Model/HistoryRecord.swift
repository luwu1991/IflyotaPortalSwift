//
//	HistoryRecord.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class HistoryRecord : NSObject{

	var createTime : String!
	var iID : String!
	var iSDelete : Bool!
	var objectIID : String!
	var objectType : String!
	var operateCentent : String!
	var operateIP : String!
	var operatePage : String!
	var operateResult : String!
	var operateType : String!
	var operationNum : Int!
	var remarks : String!
	var reserve1 : String!
	var reserve2 : String!
	var reserve3 : String!
	var reserve4 : String!
	var userAccount : String!
	var userIID : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		createTime = json["CreateTime"].stringValue
		iID = json["IID"].stringValue
		iSDelete = json["ISDelete"].boolValue
		objectIID = json["ObjectIID"].stringValue
		objectType = json["ObjectType"].stringValue
		operateCentent = json["OperateCentent"].stringValue
		operateIP = json["OperateIP"].stringValue
		operatePage = json["OperatePage"].stringValue
		operateResult = json["OperateResult"].stringValue
		operateType = json["OperateType"].stringValue
		operationNum = json["OperationNum"].intValue
		remarks = json["Remarks"].stringValue
		reserve1 = json["Reserve1"].stringValue
		reserve2 = json["Reserve2"].stringValue
		reserve3 = json["Reserve3"].stringValue
		reserve4 = json["Reserve4"].stringValue
		userAccount = json["UserAccount"].stringValue
		userIID = json["UserIID"].stringValue
	}
}
