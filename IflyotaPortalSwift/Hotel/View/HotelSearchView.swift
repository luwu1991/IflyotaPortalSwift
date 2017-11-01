//
//  HotelSearchView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/30.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelSearchView: UIView,UIGestureRecognizerDelegate {

    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var keyword: UILabel!
    var clickDate:CallBack?
    var clickKeyword:CallBack?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapOne = UITapGestureRecognizer.init(target: self, action: #selector(tapOne(_:)))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        tapOne.delegate = self
        addGestureRecognizer(tapOne)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapOne = UITapGestureRecognizer.init(target: self, action: #selector(tapOne(_:)))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        tapOne.delegate = self
        addGestureRecognizer(tapOne)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint =  touch.location(in: self)
        if touchPoint.x > 90 {
            if clickKeyword != nil {
                clickKeyword!()
            }
        }else{
            if clickDate != nil {
                clickDate!()
            }
        }
        return true
    }
    
    @objc func tapOne(_ sender: UITapGestureRecognizer){
//        print(sender)
    }
    
    override var intrinsicContentSize: CGSize {
        var size = UILayoutFittingExpandedSize
        size.height = 30
        size.width = SCREENW - 100
        return size
    } 
}
