//
//  UIButton+Extension.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/19.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
enum LWRelayoutButtonType {
    case Nomal
    case Left
    case Bottom
}
extension UIButton {
    func centerImageAndButton(_ gap: CGFloat, type: LWRelayoutButtonType) {
        if type == LWRelayoutButtonType.Nomal {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, gap, 0, 0)
            return
        }
        
        if type == LWRelayoutButtonType.Left {
            
        }
        
    }
    
}
