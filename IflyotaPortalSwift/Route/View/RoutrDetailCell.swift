//
//  RoutrDetailCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/4.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RoutrDetailCell: UITableViewCell {

    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lineImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDate(model:ScenicSpotPostion,dayNum:String,firstSectionRow:Bool,firstTypeRow:Bool){
        tagLabel.text = model.gPRType
        titleLabel.text = model.pName
        dayTitle.text = "第" + dayNum + "天"
        if model.gPRType == "景点" {
            sceneImageView.image = UIImage.init(named: "route-icon-scene")
        }else if model.gPRType == "餐饮" {
            sceneImageView.image = UIImage.init(named: "cateringTag")
        }else{
            sceneImageView.image = UIImage.init(named: "hotelTag")
        }
        if firstSectionRow {
             dayTitle.isHidden = false
            lineImageView.image = UIImage.init(named: "cycle")
        }else{
            dayTitle.isHidden = true
            lineImageView.image = UIImage.init(named: "dottedLine")
        }
        
        if firstTypeRow {
            sceneImageView.isHidden = false
            tagLabel.isHidden = false
        }else{
            sceneImageView.isHidden = true
            tagLabel.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
