//
//  HotelDetailViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/1.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelDetailViewController: LWBaseViewController {
    var startDate = Date()
    var endDate = Date()
    var iid:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let f = DateFormatter()
        f.dateFormat = "yyy-MM-dd"
        LWNetworkTool.shareNetworkTool.loadHotelDetailWithIID(iid!, startDate: f.string(from: startDate), endDate: f.string(from: endDate)) { (hotelInfo,items) in
            print(1)
        }
        // Do any additional setup after loading the view.
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
