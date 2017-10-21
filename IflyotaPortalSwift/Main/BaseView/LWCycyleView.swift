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
    var currentPage = 1
    var type:CycyeViewCycyleType = .right
    var cycyleTime = 1.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect,subcycyleViews:[UIView],cycyleTime:Double, type:CycyeViewCycyleType) {
        

        
        super.init(frame: frame)
        self.addCycleTimer()
        self.type = type
        self.cycyleTime = cycyleTime
        if type == CycyeViewCycyleType.right {
            contentSize = CGSize (width: frame.width*CGFloat(subcycyleViews.count), height: frame.height)
        }
        else{
            contentSize = CGSize (width: frame.width, height: frame.height*CGFloat(subcycyleViews.count))
        }
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delegate = self
        
        let firstView = subcycyleViews.first!
        firstView.tag = 1
        let lastView = subcycyleViews.last!
        lastView.tag = 3
        let middleView = subcycyleViews[1]
        middleView.tag = 2
        if type == CycyeViewCycyleType.right {
            firstView.frame = CGRect (x: CGFloat(subcycyleViews.count+1)*firstView.width, y: 0, width: firstView.frame.width, height: firstView.height)
            middleView.frame = CGRect (x: middleView.width, y: 0, width: middleView.width, height: middleView.height)
            lastView.frame = CGRect (x: 0, y: 0, width: lastView.width, height: lastView.height)
        }
        else{
            firstView.frame = CGRect (x: 0, y: CGFloat(subcycyleViews.count+1)*firstView.height, width: firstView.width, height: firstView.height)
            middleView.frame = CGRect (x: 0, y: middleView.height, width: middleView.width, height: middleView.height)
            lastView.frame = CGRect (x: 0, y: 0, width: lastView.width, height: lastView.height)
        }
        
        addSubview(firstView)
        addSubview(middleView)
        addSubview(lastView)

    }
    
    func reloadData()  {
        let index = type == .right ? contentOffset.x/frame.width : contentOffset.y/frame.height
        let firstView = viewWithTag(1)
        let middleView = viewWithTag(2)
        let lastView = viewWithTag(3)
        if index == 0 && type == .right{
            middleView
        }
        
        if index == 0 && type == .bottom {
            
        }
        
        if index == 2 && type == .right {
            
        }
        
        if index == 2 && type == .bottom{
            
        }
    }
    
    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval:cycyleTime, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer, forMode:RunLoopMode.commonModes)
    }
    
    @objc func scrollToNext(){
        if self.type == .right {
            UIView.animate(withDuration: 0.4, animations: {
                self.contentOffset = CGPoint (x: 2*self.width, y: 0)
            })
        }
        else{
            UIView.animate(withDuration: 0.4, animations: {
                self.contentOffset = CGPoint (x: 0, y: 2*self.height)
            })
        }
    }
}

extension LWCycyleView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadData()
        
        scrollView.contentOffset = CGPoint (x: SCREENW, y: 0)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cycyleTimer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}
