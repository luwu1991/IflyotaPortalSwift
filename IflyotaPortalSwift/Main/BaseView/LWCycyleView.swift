 //
//  LWCycyleView.swift
//  IflyotaPortalSwift
//
//  Created by admin on 2017/10/21.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

enum CycyeViewCycyleType {
    case right
    case bottom
}

class LWCycyleView: UIScrollView {
    var cycyleTimer = Timer()
    var currentPage = 0
    var type:CycyeViewCycyleType = .right
    var cycyleTime = 1.0
    var subcycyleViews = [UIView]()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect,subcycyleViews:[UIView],cycyleTime:Double, type:CycyeViewCycyleType) {
        

        
        super.init(frame: frame)
        
        self.type = type
        self.cycyleTime = cycyleTime
        self.subcycyleViews = subcycyleViews
        self.addCycleTimer()
        self.backgroundColor = UIColor.white
        if type == CycyeViewCycyleType.right {
            contentSize = CGSize (width: frame.width*3, height: frame.height)
            contentOffset = CGPoint (x: self.width, y: 0)
        }
        else{
            contentSize = CGSize (width: frame.width, height: frame.height*3)
            contentOffset = CGPoint (x: 0, y: self.height)
        }
        
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        
        let firstView = subcycyleViews.last!
        firstView.tag = 1
        let lastView = subcycyleViews[1]
        lastView.tag = 3
        let middleView = subcycyleViews.first!
        middleView.tag = 2
        if type == CycyeViewCycyleType.right {
            firstView.frame = CGRect (x: 0, y: 0, width: firstView.width, height: firstView.height)
            middleView.frame = CGRect (x: middleView.width, y: 0, width: middleView.width, height: middleView.height)
            lastView.frame = CGRect (x: 2*middleView.width, y: 0, width: lastView.width, height: lastView.height)
        }
        else{
            firstView.frame = CGRect (x: 0, y: 0, width: firstView.width, height: firstView.height)
            middleView.frame = CGRect (x: 0, y: middleView.height, width: middleView.width, height: middleView.height)
            lastView.frame = CGRect (x: 0, y: 2*middleView.height, width: lastView.width, height: lastView.height)
        }
        
        addSubview(firstView)
        addSubview(middleView)
        addSubview(lastView)

    }
    
    func reloadData()  {
        let index = type == .right ? contentOffset.x/frame.width : contentOffset.y/frame.height
        var firstView = viewWithTag(1)!
        var middleView = viewWithTag(2)!
        var lastView = viewWithTag(3)!
        
        firstView.removeFromSuperview()
        middleView.removeFromSuperview()
        lastView.removeFromSuperview()
        
        
        if index == 0 && type == .right{
            currentPage = (currentPage - 1 + subcycyleViews.count) % subcycyleViews.count
            firstView = subcycyleViews[(currentPage - 1 + subcycyleViews.count) % subcycyleViews.count]
            middleView = subcycyleViews[currentPage]
            lastView = subcycyleViews[(currentPage + 1 + subcycyleViews.count) % subcycyleViews.count]
            
            firstView.frame = CGRect (x: 0, y: 0, width: self.width, height: self.height)
            middleView.frame = CGRect (x: self.width, y: 0, width: self.width, height: self.height)
            lastView.frame = CGRect (x: 2*self.width, y: 0, width: self.width, height: self.height)
        }
        
        if index == 0 && type == .bottom {
            currentPage = (currentPage - 1 + subcycyleViews.count) % subcycyleViews.count
            firstView = subcycyleViews[(currentPage - 1 + subcycyleViews.count) % subcycyleViews.count]
            middleView = subcycyleViews[currentPage]
            lastView = subcycyleViews[(currentPage + 1 + subcycyleViews.count) % subcycyleViews.count]
            
            firstView.frame = CGRect (x: 0, y: 0, width: self.width, height: self.height)
            middleView.frame = CGRect (x: 0, y: self.height, width: self.width, height: self.height)
            lastView.frame = CGRect (x: 0, y: 2*self.height, width: self.width, height: self.height)
        }
        
        if index == 2 && type == .right {
            currentPage = (currentPage + 1 + subcycyleViews.count) % subcycyleViews.count
            firstView = subcycyleViews[(currentPage - 1 + subcycyleViews.count) % subcycyleViews.count]
            middleView = subcycyleViews[currentPage]
            lastView = subcycyleViews[(currentPage + 1 + subcycyleViews.count) % subcycyleViews.count]
            
            firstView.frame = CGRect (x: 0, y: 0, width: self.width, height: self.height)
            middleView.frame = CGRect (x: self.width, y: 0, width: self.width, height: self.height)
            lastView.frame = CGRect (x: 2*self.width, y: 0, width: self.width, height: self.height)
        }
        
        if index == 2 && type == .bottom{
            currentPage = (currentPage + 1 + subcycyleViews.count) % subcycyleViews.count
           
            firstView = subcycyleViews[(currentPage - 1 + subcycyleViews.count) % subcycyleViews.count]
            middleView = subcycyleViews[currentPage]
            lastView = subcycyleViews[(currentPage + 1 + subcycyleViews.count) % subcycyleViews.count]
            
            firstView.frame = CGRect (x: 0, y: 0, width: self.width, height: self.height)
            middleView.frame = CGRect (x: 0, y: self.height, width: self.width, height: self.height)
            lastView.frame = CGRect (x: 0, y: 2*self.height, width: self.width, height: self.height)
           
            
        }
        firstView.tag = 1
        middleView.tag = 2
        lastView.tag = 3
        addSubview(firstView)
        addSubview(middleView)
        addSubview(lastView)
        
    }
    
    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval:cycyleTime, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer, forMode:RunLoopMode.commonModes)
    }
    
    @objc func scrollToNext(){
        if self.type == .right {
            UIView.animate(withDuration: 0.4, animations: {
                self.contentOffset = CGPoint (x: 2*self.width, y: 0)
            }) { (success) in
               self.reloadData()
                self.contentOffset = CGPoint (x: self.width, y: 0)
            }
        }
        else{
            UIView.animate(withDuration: 0.4, animations: {
                self.contentOffset = CGPoint (x: 0, y: 2*self.height)
            }){ (success) in
                self.reloadData()
                self.contentOffset = CGPoint (x: 0, y: self.height)
            }
        }
    }
}

extension LWCycyleView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadData()
        
        if type == .right {
            scrollView.contentOffset = CGPoint (x: scrollView.width, y: 0)
        }
        else{
            scrollView.contentOffset = CGPoint (x: 0, y: scrollView.height)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cycyleTimer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}
