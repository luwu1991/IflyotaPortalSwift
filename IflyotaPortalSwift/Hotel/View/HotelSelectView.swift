//
//  HotelSelectView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import Foundation

@objc protocol HotelSelectViewDelegate{
    
   
    @objc optional func clickDateBtn(_ btn:UIButton)
    
   @objc optional func clickSelectHotelBtn(_ btn:UIButton)
    
   @objc optional func clickPriceBtn(_ btn:UIButton)
    
   @objc optional func clickSearchBtn(_ btn:UIButton)
}

class HotelSelectView: UIView {
    var delagate:HotelSelectViewDelegate?
    @IBAction func clickDateBtn(_ sender: Any) {
        delagate?.clickDateBtn?(sender as! UIButton)
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var totalDaylabel: UILabel!
    
    @IBAction func clickSelectHotelBtn(_ sender: Any) {
        delagate?.clickSelectHotelBtn?(sender as! UIButton)
    }
    @IBOutlet weak var hotelLabel: UILabel!
    
    @IBAction func clickPriceBtn(_ sender: Any) {
        delagate?.clickPriceBtn?(sender as! UIButton)
    }
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func clickSearchBtn(_ sender: Any) {
        delagate?.clickSearchBtn?(sender as! UIButton)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
