//
//  HotelViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelViewController: LWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "酒店"
//        navigationController?.navigationBar.isHidden = false
        self.automaticallyAdjustsScrollViewInsets = false
        LWNetworkTool.shareNetworkTool.loadRollChartList(pageName: "酒店", moduleName: "顶部") { (items) in
            var datas = [HomePageBannel]()
            if items.count == 1{
                datas.append(items.first!)
                datas.append(items.last!)
                datas.append(items.first!)
            }
            self.initBanelView(datas: datas)
        }
        initHotelSelectView()
    }

    
 
    
    func initBanelView(datas:[HomePageBannel]){
        var banelViews = [UIImageView]()
        for index in 0...datas.count - 1{
            let imageView = UIImageView()
            let model = datas[index]
            imageView.frame = CGRect(x: index*Int(SCREENW), y: 0, width: Int(SCREENW), height: 120)
            imageView.kf.setImage(with: URL(string: model.resourceUrl))
            banelViews.append(imageView)
        }
        
        let banelView = LWCycyleView.init(frame: CGRect (x: 0, y: 64, width: SCREENW, height: 120), subcycyleViews: banelViews, cycyleTime: 2.0, type: .right)
        view.addSubview(banelView)
    }
    
    func initHotelSelectView(){
        let hotelSelectView = Bundle.main.loadNibNamed("HotelSelectView", owner: nil, options: nil)?.first as! HotelSelectView
        hotelSelectView.delagate = self
        hotelSelectView.frame = CGRect(x: 10, y: 194, width: SCREENW - 20, height: 290)
        view.addSubview(hotelSelectView)
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HotelViewController:HotelSelectViewDelegate{
    func clickDateBtn(_ btn: UIButton) {
        let calenVC = CalendarViewController()
        self.navigationController?.pushViewController(calenVC, animated: true)
    }
    
    func clickPriceBtn(_ btn: UIButton) {
        print(1)
    }
    
    func clickSearchBtn(_ btn: UIButton) {
        print(1)
    }
    
    func clickSelectHotelBtn(_ btn: UIButton) {
        print(1)
    }
}


