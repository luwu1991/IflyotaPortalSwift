//
//	RouteDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RouteDetail : NSObject{

	var guideDetails : [GuideDetail]!
	var imageUrl : String!
	var imgs : [RouteDetailImg]!
	var lIIID : String!
	var lIIllustration : String!
	var lIName : String!
	var lINotes : String!
	var lISubhead : String!
	var lITripDayNumber : Int!
	var minPrice : Int!
	var tName : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		guideDetails = [GuideDetail]()
		let guideDetailsArray = json["GuideDetails"].arrayValue
		for guideDetailsJson in guideDetailsArray{
			let value = GuideDetail(fromJson: guideDetailsJson)
			guideDetails.append(value)
		}
		imageUrl = json["ImageUrl"].stringValue
		imgs = [RouteDetailImg]()
		let imgsArray = json["Imgs"].arrayValue
		for imgsJson in imgsArray{
			let value = RouteDetailImg(fromJson: imgsJson)
			imgs.append(value)
		}
		lIIID = json["LIIID"].stringValue
		lIIllustration = json["LIIllustration"].stringValue
		lIName = json["LIName"].stringValue
		lINotes = json["LINotes"].stringValue
		lISubhead = json["LISubhead"].stringValue
		lITripDayNumber = json["LITripDayNumber"].intValue
		minPrice = json["MinPrice"].intValue
		tName = json["TName"].stringValue
	}
}

class RouteDetailImg : NSObject{
    
    var imgResourceName : String!
    var imgResourceUrl : String!
    var imgType : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        imgResourceName = json["ImgResourceName"].stringValue
        imgResourceUrl = json["ImgResourceUrl"].stringValue
        imgType = json["ImgType"].stringValue
    }
}

class GuideDetail : NSObject{
    
    var cateringPostions : [String]!
    var dayNumber : String!
    var hotelPostions : [String]!
    var scenicSpotPostions : [ScenicSpotPostion]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        cateringPostions = [String]()
        let cateringPostionsArray = json["CateringPostions"].arrayValue
        for cateringPostionsJson in cateringPostionsArray{
            cateringPostions.append(cateringPostionsJson.stringValue)
        }
        dayNumber = json["DayNumber"].stringValue
        hotelPostions = [String]()
        let hotelPostionsArray = json["HotelPostions"].arrayValue
        for hotelPostionsJson in hotelPostionsArray{
            hotelPostions.append(hotelPostionsJson.stringValue)
        }
        scenicSpotPostions = [ScenicSpotPostion]()
        let scenicSpotPostionsArray = json["ScenicSpotPostions"].arrayValue
        for scenicSpotPostionsJson in scenicSpotPostionsArray{
            let value = ScenicSpotPostion(fromJson: scenicSpotPostionsJson)
            scenicSpotPostions.append(value)
        }
    }

}

class ScenicSpotPostion : NSObject{
    
    var gPRNumber : Int!
    var gPRType : String!
    var pName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        gPRNumber = json["GPRNumber"].intValue
        gPRType = json["GPRType"].stringValue
        pName = json["PName"].stringValue
    }
    
}


