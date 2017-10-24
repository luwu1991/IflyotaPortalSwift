//
//  LWSwiperView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/23.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LWSwiperView: UIView {

    var tags:[TagModel] = [TagModel]()
    var tagsView:UIView = UIView()
    var scrollView = UIScrollView()
    var selectBtn:UIButton?
    var myContext:NSObject!
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder) has not been implemented")
    }
    
    init(frame: CGRect,tags:[TagModel]) {
        super.init(frame: frame)
        self.tags = tags
        self.myContext = NSObject()
        initTagsView()
        initBottomScrollview()
    }
    
    func initTagsView() {
        self.tagsView = UIView()
        tagsView.backgroundColor = UIColor.white
        tagsView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 40)
        addSubview(tagsView)
        
        for index in 0...tags.count - 1{
            let tag = tags[index].tName
            let tagBtnW = 75
            let tagBtnspace = (SCREENW - 70 - CGFloat(3*tagBtnW))/2
            let tagBtn = UIButton()
            tagBtn.tag = index + 1
            tagBtn.frame = CGRect(x: 35+index*(tagBtnW+Int(tagBtnspace)), y: 5, width: tagBtnW, height: 30)
            tagBtn.setTitle(tag, for: UIControlState.normal)
            tagBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
            tagBtn.setTitleColor(UIColor.white, for: UIControlState.selected)
            tagBtn.backgroundColor = UIColor.white
            tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            tagBtn.titleLabel?.sizeToFit()
            tagBtn.layer.masksToBounds = true
            tagBtn.layer.cornerRadius = 15
            tagBtn.addTarget(self, action: #selector(clickTagBtn), for: UIControlEvents.touchUpInside)
            if index == 0 {
                tagBtn.isSelected = true
                tagBtn.backgroundColor = ThemeColor()
                selectBtn = tagBtn
            }
            tagsView.addSubview(tagBtn)
        }
    }
    
    func initBottomScrollview() {
        scrollView.frame = CGRect(x: 0, y: 40, width: SCREENW, height: SCREENH - 40)
        scrollView.backgroundColor = garyColor
        scrollView.contentSize = CGSize(width: CGFloat(tags.count)*SCREENW, height: SCREENH - 40)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.addObserver(self, forKeyPath: "frame", options: .new, context: &myContext)
        addSubview(scrollView)
    }
    
    //MASR:
    @objc func clickTagBtn(sender:UIButton){
        if sender == selectBtn {
            return
        }
        
        sender.isSelected = true
        sender.backgroundColor = ThemeColor()
        selectBtn?.isSelected = false
        selectBtn?.backgroundColor = UIColor.white
        selectBtn = sender
        
        scrollView.setContentOffset(CGPoint (x: CGFloat(sender.tag - 1)*scrollView.width, y: scrollView.contentOffset.y), animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext{
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                print("Date changed: \(newValue)")
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension LWSwiperView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.width
        let btn = tagsView.viewWithTag(Int(index + 1)) as! UIButton
        
        if btn == selectBtn {
            return
        }
        btn.isSelected = true
        btn.backgroundColor = ThemeColor()
        selectBtn?.isSelected = false
        selectBtn?.backgroundColor = UIColor.white
        selectBtn = btn
    }
}
