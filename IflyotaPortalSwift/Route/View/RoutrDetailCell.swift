//
//  RoutrDetailCell.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/4.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RoutrDetailCell: UITableViewCell {

    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lineImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
