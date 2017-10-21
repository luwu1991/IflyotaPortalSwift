//
//  ScenicSpotView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/21.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class ScenicSpotView: UIView {

    public var scrollView:UIScrollView
    
    required init(coder aDecoder:NSCoder) {
        self.scrollView = UIScrollView()
        super.init(coder: aDecoder)!
         setLayout()
    }
    
    override init(frame: CGRect) {
        self.scrollView = UIScrollView()
        super.init(frame: frame)
        setLayout()
    }
    
    func setLayout(){
        backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.frame = CGRect (x: 4, y: 10, width: 120, height: 20)
        titleLabel.text = "当季热门景点"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        let moreBtn = UIButton()
        moreBtn.frame = CGRect (x: SCREENW - 50, y: 10, width: 40, height: 20)
        moreBtn.setTitle("更多", for: UIControlState.normal)
        moreBtn.setTitleColor(LWColor(r: 186, g: 186, b: 186, a: 186), for: UIControlState.normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addSubview(titleLabel)
        addSubview(moreBtn)
        
        scrollView.backgroundColor = UIColor.white
    }

}
