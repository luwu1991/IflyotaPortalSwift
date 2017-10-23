//
//  LWConst.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/18.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit


//let BASE_URL = "http://app.iflyota.com/Trip.Web_IOS_Test/parts/Common/WapProxy.ashx/"
let BASE_URL = "http://app.iflyota.com/Trip.Web_Android_JD/parts/Common/WapProxy.ashx/"
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height


func LWColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


let garyColor = LWColor(r: 243, g: 243, b: 243, a: 1.0)

func ThemeColor() -> UIColor {
    return LWColor(r: 51, g: 229, b: 200, a: 1.0)
}

