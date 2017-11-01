//
//  LineListCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/23.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LineListCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }

}
