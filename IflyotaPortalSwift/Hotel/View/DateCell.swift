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
    case noneSelect
}
class DateCell:JTAppleCell {
    private var mycontext = 0
    @IBOutlet weak var Daylabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    let backThemeColor = LWColor(r: 245, g: 245, b: 245, a: 1.0)
    var selectPosition:DateCellSelectPositionType = .noneSelect{
        willSet{
            self.layer.cornerRadius = 0
            if newValue == .first {
                
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: self.width/2, height: self.height/2))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
                self.Daylabel.textColor = UIColor.white
                self.subTitle.text = "入住"
                self.backgroundColor = ThemeColor()
            }
            
            if newValue == .last {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: self.width/2, height: self.height/2))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
                self.Daylabel.textColor = UIColor.white
                self.subTitle.text = "离店"
                self.backgroundColor = ThemeColor()
            }
            
            if newValue == .only {
                self.Daylabel.textColor = UIColor.white
                self.layer.cornerRadius = self.height/2
                self.backgroundColor = ThemeColor()
            }
            
            if newValue == .middle {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight,.bottomRight,.topLeft,.bottomLeft], cornerRadii: CGSize(width: 0, height: 0))
                let maskLayer1 = CAShapeLayer()
                maskLayer1.frame = self.bounds
                maskLayer1.path = path.cgPath
                self.layer.mask = maskLayer1
                self.Daylabel.textColor = UIColor.white
                self.subTitle.text = ""
                self.backgroundColor = ThemeColor()
            }
            
            if newValue == .noneSelect {
                if self.selectPosition != newValue{
                    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight,.bottomRight,.topLeft,.bottomLeft], cornerRadii: CGSize(width: 0, height: 0))
                    let maskLayer1 = CAShapeLayer()
                    maskLayer1.frame = self.bounds
                    maskLayer1.path = path.cgPath
                    self.layer.mask = maskLayer1
                    self.layer.cornerRadius = 0
                    self.subTitle.text = ""
                    self.backgroundColor = backThemeColor
                    self.Daylabel.textColor = UIColor.black
                }
            }
            
        }
    }
    
    
}
