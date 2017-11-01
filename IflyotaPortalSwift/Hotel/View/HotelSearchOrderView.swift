//
//  HotelSearchOrderView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/31.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelSearchOrderView: UIView,UIGestureRecognizerDelegate{
    
    let orderView = UIView()
    var clickBtnCallBack:((_ sord:String) -> ())?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = LWColor(r: 50, g: 50, b: 50, a: 0.5)
        isOpaque = false
        
        initOrderView()
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        tapOne.delegate = self
        self.addGestureRecognizer(tapOne)
    }
    
    func initOrderView(){
        addSubview(orderView)
        orderView.backgroundColor = UIColor.white
        orderView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(150)
        }
        
        let firstBtn = UIButton()
        firstBtn.setTitle("默认排序", for: UIControlState.normal)
        firstBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        firstBtn.setTitleColor(ThemeColor(), for: UIControlState.selected)
        firstBtn.tag = 1
        firstBtn.isSelected = true
        firstBtn.addTarget(self, action: #selector(clickBtn(_:)), for: UIControlEvents.touchUpInside)
        orderView.addSubview(firstBtn)
        firstBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
        }
        
        
        let secondBtn = UIButton()
        secondBtn.setTitle("按价格从低到高", for: UIControlState.normal)
        secondBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        secondBtn.setTitleColor(ThemeColor(), for: UIControlState.selected)
        secondBtn.tag = 2
        secondBtn.addTarget(self, action: #selector(clickBtn(_:)), for: UIControlEvents.touchUpInside)
        orderView.addSubview(secondBtn)
        secondBtn.snp.makeConstraints { (make) in
            make.top.equalTo(firstBtn.snp.bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
        }
        
        let thirdBtn = UIButton()
        thirdBtn.setTitle("按价格从高到底", for: UIControlState.normal)
        thirdBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        thirdBtn.setTitleColor(ThemeColor(), for: UIControlState.selected)
        thirdBtn.tag = 3
        thirdBtn.addTarget(self, action: #selector(clickBtn(_:)), for: UIControlEvents.touchUpInside)
        orderView.addSubview(thirdBtn)
        thirdBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secondBtn.snp.bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(50)
        }
        
    }
    //MRAK:action
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint =  touch.location(in: self)
        return !orderView.frame.contains(touchPoint)
    }
    @objc func tapView(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3) {
            self.y = SCREENH
        }
    }
    
    @objc func clickBtn(_ sender:UIButton){
        for index in 1...3{
            let btn = orderView.viewWithTag(index) as! UIButton
            btn.isSelected = false
        }
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            if clickBtnCallBack != nil {
                clickBtnCallBack!("HRecommendedOrder")
                UIView.animate(withDuration: 0.3) {
                    self.y = SCREENH
                }
            }
        case 2:
            if clickBtnCallBack != nil {
                clickBtnCallBack!("MinPrice")
                UIView.animate(withDuration: 0.3) {
                    self.y = SCREENH
                }
            }
        case 3:
            if clickBtnCallBack != nil {
                clickBtnCallBack!("MaxPrice")
                UIView.animate(withDuration: 0.3) {
                    self.y = SCREENH
                }
            }
        default:
            break
        }
        
        
    }

}
