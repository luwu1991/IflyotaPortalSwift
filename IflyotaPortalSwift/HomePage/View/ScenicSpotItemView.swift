//
//  ScenicSpotItemView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/23.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import Kingfisher
class ScenicSpotItemView: UICollectionViewCell {

    @IBOutlet public weak var imageView: UIImageView!
    
    @IBOutlet public weak var titleLabel: UILabel!
    
    @IBOutlet public weak var priceLabel: UILabel!
    
    
    @IBOutlet public weak var subTitle: UILabel!
    
 
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
