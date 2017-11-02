//
//  RoomCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/2.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusLabel.layer.cornerRadius = 12.5
        statusLabel.layer.masksToBounds = true
        
        leftImageView.layer.cornerRadius = 4
        leftImageView.layer.masksToBounds = true
    }

    func setDate(model:HotelRoom){
        self.leftImageView.kf.setImage(with: URL.init(string: model.hotelRoomInfo.resourceUrl))
        self.nameLabel.text = model.hotelRoomInfo.hRName+"/"+model.hotelRoomInfo.hRType
        self.priceLabel.text = "￥\(model.price.pLPrice!).00"
        if model.hotelRoomInfo.hRStatus == "空房" {
            self.statusLabel.backgroundColor = ThemeColor()

        }else{
            self.statusLabel.backgroundColor = LWColor(r: 200, g: 201, b: 202, a: 1.0)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
