//
//  CalenderHeaderView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/25.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SnapKit
class CalenderHeaderView: JTAppleCollectionReusableView {
    
    var titleLabel:UILabel
    required init?(coder aDecoder: NSCoder) {
        self.titleLabel = UILabel()
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        super.init(frame: frame)
        initSubView()
    }
    
    func initSubView(){
        addSubview(titleLabel)
        self.backgroundColor = LWColor(r: 245, g: 245, b: 245, a: 1.0)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = LWColor(r: 95, g: 95, b: 95, a: 1.0)
//        titleLabel.sizeToFit()
        
    }
}
