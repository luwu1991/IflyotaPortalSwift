//
//  DateCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/25.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import JTAppleCalendar
enum DateCellSelectPositionType {
    case first
    case last
    case only
    case middle
}
class DateCell:JTAppleCell {

    @IBOutlet weak var Daylabel: UILabel!
    var selectPosition:DateCellSelectPositionType?{
        willSet{
            self.layer.cornerRadius = 0
            if newValue == .first {
                
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: self.width/2, height: self.height/2))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
            }
            
            if newValue == .last {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: self.width/2, height: self.height/2))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
            }
            
            if newValue == .only {
                self.layer.cornerRadius = self.height/2
            }
            
            if newValue == .middle {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight,.bottomRight,.topLeft,.bottomLeft], cornerRadii: CGSize(width: 0, height: 0))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
            }
            
        }
    }
}
