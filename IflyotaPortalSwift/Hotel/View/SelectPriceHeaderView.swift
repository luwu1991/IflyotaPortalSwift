//
//  SelectPriceHeaderView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/29.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class SelectPriceHeaderView: UICollectionReusableView {

    @IBAction func clickCloseBtn(_ sender: Any) {
        if clickCloseBtnCalllBack != nil {
            clickCloseBtnCalllBack!()
        }
    }
    var clickCloseBtnCalllBack:CallBack?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
