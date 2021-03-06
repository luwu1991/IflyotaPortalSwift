//
//  HotelViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import SnapKit
class HotelViewController: LWBaseViewController {
    
    var startDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    var endDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    var keyword:String?
    let hotelSelectView = Bundle.main.loadNibNamed("HotelSelectView", owner: nil, options: nil)?.first as! HotelSelectView
    let bottomBtnW = (SCREENW - 20 - 2)/2
    var starLevel:String?
    var minPrice:String?
    var maxPrice:String?
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
        initBottomBtn()
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
    
    func initBottomBtn() {
        let btnFrame = CGRect(x: 0, y: 0, width: bottomBtnW, height: 50)
        
        let leftBtn = UIButton()
        leftBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        leftBtn.setTitle("我的订单", for: UIControlState.normal)
        view.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.width.equalTo((SCREENW - 20 - 2)/2)
            make.left.equalTo(10)
            make.top.equalTo(hotelSelectView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        let path = UIBezierPath(roundedRect: btnFrame, byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: 4, height: 4))
        let leftMask = CAShapeLayer()
        leftMask.frame = btnFrame
        leftMask.path = path.cgPath
        leftBtn.layer.mask = leftMask
        leftBtn.backgroundColor = UIColor.white
        
        let rightBtn = UIButton()
        
        rightBtn.setTitle("我的订单", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        view.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.width.equalTo((SCREENW - 20 - 2)/2)
            make.right.equalTo(-10)
            make.top.equalTo(hotelSelectView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        
        let rightPath = UIBezierPath(roundedRect: btnFrame, byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: 4, height: 4))
        let rightMask = CAShapeLayer()
        rightMask.frame = btnFrame
        rightMask.path = rightPath.cgPath
        rightBtn.layer.mask = rightMask
        rightBtn.backgroundColor = UIColor.white
    }
    
    fileprivate func updatePriceLabel(){
        if self.starLevel == nil && self.minPrice == nil && self.maxPrice == nil {
            hotelSelectView.priceLabel.text = "价格/星级"
            hotelSelectView.priceLabel.textColor = UIColor.black
            return
        }
        hotelSelectView.priceLabel.textColor = ThemeColor()
        if self.minPrice != nil {
            if self.maxPrice != nil{
                hotelSelectView.priceLabel.text = "￥\(self.minPrice!)-￥\(self.maxPrice!)"
            }else{
                hotelSelectView.priceLabel.text = "￥\(self.minPrice!)以上"
            }
            
            hotelSelectView.priceLabel.text = hotelSelectView.priceLabel.text! + " " + (self.starLevel ?? "")
            
            return
        }
        
        if self.maxPrice != nil {
            hotelSelectView.priceLabel.text = "￥\(self.maxPrice!)以下"
            hotelSelectView.priceLabel.text = hotelSelectView.priceLabel.text! + " " + (self.starLevel ?? "")
        }
        
        if self.maxPrice == nil {
            hotelSelectView.priceLabel.text = self.starLevel
        }
        
        
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
        let priceSelectVC = SelectPriceViewController()
        priceSelectVC.starLevel = self.starLevel
        priceSelectVC.minPrice = self.minPrice
        priceSelectVC.maxPrice = self.maxPrice
        priceSelectVC.sendValueCallBack = { (startLevel,minValue,maxValue) in
            self.starLevel = startLevel
            self.minPrice = minValue
            self.maxPrice = maxValue
            self.updatePriceLabel()
        }
        priceSelectVC.modalPresentationStyle = .overCurrentContext
        present(priceSelectVC, animated: true, completion: nil)
    }
    
    func clickSearchBtn(_ btn: UIButton) {
        let searchHotelListVC = SearchHotelListViewController()
        searchHotelListVC.startDate = startDate
        searchHotelListVC.endDate = endDate
        searchHotelListVC.keyword = self.keyword
        searchHotelListVC.minPrice = minPrice
        searchHotelListVC.maxPrice = maxPrice
        searchHotelListVC.starLevel = starLevel
        searchHotelListVC.sendValueCallBack = {[weak self] (starLevel,minPrice,maxPrice,startDate,endDate,keyword) in
            self?.starLevel = starLevel
            self?.minPrice = minPrice
            self?.maxPrice = maxPrice
            self?.startDate = startDate!
            self?.endDate = endDate!
            self?.keyword = keyword
        }
        self.navigationController?.pushViewController(searchHotelListVC, animated: true)
    }
    
    func clickSelectHotelBtn(_ btn: UIButton) {
        let searchVC = SearchHotelViewController.init(type: .Hotel)
        searchVC.searchTitleCallBack = {(searchTitle) in
            self.keyword = searchTitle
            self.hotelSelectView.hotelLabel.text = searchTitle
            self.hotelSelectView.hotelLabel.textColor = ThemeColor()
        }
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}


