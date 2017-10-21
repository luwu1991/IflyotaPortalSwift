//
//  LWTableViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/18.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LWTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = ThemeColor()
        
        addChildViewControllers()
        
       
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return selectedViewController
    }


    func addChildViewControllers() -> Void {
        addChildViewController(HomepageViewController(), title: "首页", imageName:"botmenu_home_normal", selectImage: "botmenu_home_selected")
        addChildViewController(NearbyViewController(), title: "附近", imageName: "botmenu_find_normal", selectImage: "botmenu_find_selected")
        addChildViewController(SpeechViewController(), title: "", imageName: "botmenu_voice_selected", selectImage: "botmenu_voice_selected")
        addChildViewController(ThemeViewController(), title: "主题游", imageName: "botmenu_theme_normal", selectImage: "botmenu_theme_selected")
        addChildViewController(MeViewController(), title: "我的", imageName: "botmenu_profile_normal", selectImage: "botmenu_profile_selected")
    }
    
    
    func addChildViewController(_ childController: UIViewController,title:String, imageName: String,selectImage:String) {
        
        let AttN = [NSAttributedStringKey.foregroundColor:UIColor.black]
        let AttS = [NSAttributedStringKey.foregroundColor:ThemeColor()]
        
        childController.tabBarItem.image = UIImage(named:imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named:selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.title = title
        childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5)
        childController.tabBarItem.setTitleTextAttributes(AttN, for: UIControlState.normal)
        childController.tabBarItem.setTitleTextAttributes(AttS, for: UIControlState.selected)
        
        
        if title == ""{
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0)
        }
        let navVC = LWNavigationController (rootViewController: childController)
        addChildViewController(navVC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
