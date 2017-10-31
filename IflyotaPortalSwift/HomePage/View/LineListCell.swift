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
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 4, height: 4))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
//        self.layer.mask = maskLayer
    }

}
