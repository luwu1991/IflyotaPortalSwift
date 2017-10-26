//
//  HotelViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HotelViewController: LWBaseViewController {
    
    var startDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    var endDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    let hotelSelectView = Bundle.main.loadNibNamed("HotelSelectView", owner: nil, options: nil)?.first as! HotelSelectView
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
        hotelSelectView.delagate = self
        hotelSelectView.frame = CGRect(x: 10, y: 194, width: SCREENW - 20, height: 290)
        setDateText()
        view.addSubview(hotelSelectView)
    }
    
    
    
    fileprivate func setDateText() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let startDateText = formatter.string(from: startDate)
        let endDateText = formatter.string(from: endDate)
        hotelSelectView.dateLabel.text = startDateText + " - "+endDateText
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        hotelSelectView.totalDaylabel.text = "共\(components.day!)晚"
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
        calenVC.dateCallBack = {(startDate,endDate) in
            self.startDate = startDate
            self.endDate = endDate
            self.setDateText()
        }
        calenVC.startDate = self.startDate
        calenVC.endDate = self.endDate
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


