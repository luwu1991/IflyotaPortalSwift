//
//  LWNavigationController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/20.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LWNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    private var shadowImageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.white
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under:self.navigationBar)
        }
        shadowImageView?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        shadowImageView?.isHidden = false
    }
    
    /// 重写push方法,每次push都为下一个控制器修改统一的返回按钮以及手势.
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //判断当前的栈内有几个视图.为0的话是根控制器,根控制器不需要设置返回按钮以及返回手势
        if self.childViewControllers.count > 0  {
            //设置返回按钮,这里使用的分类中自定义的创建方法.分类在3.4

            let emptyBar = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            emptyBar.width = -40
            let leftBtn = UIBarButtonItem(title: "" , image: UIImage(named: "btn_back"), highlightedImage: UIImage(named: "btn_back"), target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItems = [emptyBar,leftBtn]
            viewController.navigationController?.navigationBar.shadowImage = UIImage()
            //获取返回手势的代理
            let target = interactivePopGestureRecognizer?.delegate
            
            //自定义手势添加到返回手势的代理上
            let pan = UIScreenEdgePanGestureRecognizer(target: target, action: NSSelectorFromString("handleNavigationTransition:"))
            pan.edges = UIRectEdge.left
            
            //如果需要使用全屏侧滑返回,可以直接使用pan手势,并且很奇妙的是也只能从左往右滑动生效
            //let pan =  UIPanGestureRecognizer(target: target, action: NSSelectorFromString("handleNavigationTransition:"))
            //将自定义手势添加到控制器的View上
            viewController.view.addGestureRecognizer(pan)
            
            //设置代理,控制手势是否开启,以及滑动的方向距离等.若不需要可以不设置
            pan.delegate = self
            
            // 设置返回手势
            interactivePopGestureRecognizer?.isEnabled = true
        }
        
        //调用父类方法
        super.pushViewController(viewController, animated: animated)
        
        /// 结束重写
    }
    
    /// 返回按钮绑定的点击事件
    @objc private func back() {
        popViewController(animated: true)
    }
    
    /// 手势的代理,开启手势识别.弱不需要额外的控制可以不设置
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    

    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension UINavigationController{
    public func setNeedsNavigationBackground(alpha:CGFloat){
        let barBackgroundView = self.navigationBar.subviews.first
        let backgroundImageView = barBackgroundView?.subviews.first as? UIImageView
        if self.navigationBar.isTranslucent {
            if backgroundImageView != nil && backgroundImageView?.image != nil{
                barBackgroundView?.alpha = alpha
            }else{
                let backgroundEffectView = barBackgroundView?.subviews[1]
                if backgroundEffectView != nil{
                    backgroundEffectView?.alpha = alpha
                }
            }
        }else{
            barBackgroundView?.alpha = alpha
        }
    }
}

extension UIBarButtonItem {
    convenience init(title : String = "" , image : UIImage? , highlightedImage : UIImage? , target: Any?, action: Selector) {
        let barButton = UIButton()
        //设置title
        barButton.setTitle(title, for: .normal)
        barButton.setTitleColor(UIColor.init(red: 0.24, green: 0.24, blue: 0.24, alpha: 1), for: .normal)
        barButton.setTitleColor(UIColor.init(red: 1, green: 0.46, blue: 0, alpha: 1), for: .highlighted)
        barButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        //设置图片
        if let image = image {
            barButton.setImage(image, for: .normal)
        }
        
        //高亮图片
        if let highlightedImage = highlightedImage {
            barButton.setImage(highlightedImage, for: .highlighted)
        }
        
        //添加target
        barButton.addTarget(target, action: action, for: .touchUpInside)
        
        //尺寸适应
        barButton.size = CGSize (width: 44, height: 44)
        barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20)
        //构造.
        self.init()
        
        //添加到CustomView
        customView = barButton
    }
}


