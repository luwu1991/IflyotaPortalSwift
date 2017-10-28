//
//  HotelSearchHistoryCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/27.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelSearchHistoryCell: UICollectionViewCell {

    var titleLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect (x: 0, y: 0, width: SCREENW - 30, height: 44)
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(SCREENW - 40)
            make.right.equalToSuperview()
        }
    }

}
