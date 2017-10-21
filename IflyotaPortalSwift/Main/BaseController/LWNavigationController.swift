//
//  LWNavigationController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/20.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
