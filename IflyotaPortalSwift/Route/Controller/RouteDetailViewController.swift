//
//  RouteDetailViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/3.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RouteDetailViewController: LWBaseViewController {
    var model:Route?
    var routeDetailModel:RouteDetail?
    let topViewHeight = SCREENW*540/755 + 150
    let mainScrollView = UIScrollView()
    let menuView = UIView()
    let guideView = UIView()
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 200), style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = true
        mainScrollView.backgroundColor = view.backgroundColor
        mainScrollView.frame = CGRect.init(x: 0, y: -64, width: SCREENW, height: SCREENH + 64)
        mainScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH)
        view.addSubview(mainScrollView)
        
        initTopView()
        initMenuView()
        initGuideView()
        netWorking()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNeedsNavigationBackground(alpha:0.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNeedsNavigationBackground(alpha:1.0)
    }
    
    //MARK:NetWorking
    func netWorking(){
        LWNetworkTool.shareNetworkTool.loadRouteDetailWith(iid: model!.lIIID) { (item) in
            self.routeDetailModel = item
            self.updateView()
        }
    }
    
    func initTopView(){
        let topImageView = UIImageView()
        topImageView.kf.setImage(with: URL.init(string: model!.imgUrl!))
        topImageView.tag = 1
        mainScrollView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENW*540/755)
        }
        
        let topTitleView = UIView()
        topTitleView.backgroundColor = UIColor.white
        mainScrollView.addSubview(topTitleView)
        topTitleView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.top.equalTo(topImageView.snp.bottom)
            make.height.equalTo(85)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "[\(model!.tName!)]\(model!.lIName!)"
        titleLabel.sizeToFit()
        topTitleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(20)
        }
        
        let priceTitle = UILabel()
        priceTitle.textColor = ThemeColor()
        priceTitle.text = "￥\(model!.pLPrice!)"
        topTitleView.addSubview(priceTitle)
        priceTitle.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(-20)
        }
        
        let intrView = UIView()
        intrView.backgroundColor = UIColor.white
        mainScrollView.addSubview(intrView)
        intrView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.top.equalTo(topTitleView.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        let intrLabel = UILabel()
        intrLabel.font = UIFont.systemFont(ofSize: 14)
        intrLabel.text = "线路介绍"
        intrLabel.sizeToFit()
        intrView.addSubview(intrLabel)
        intrLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        let rightImg = UIImageView()
        rightImg.image = UIImage.init(named: "right")
        intrView.addSubview(rightImg)
        rightImg.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
   
    func initMenuView(){
        menuView.backgroundColor = UIColor.white
        menuView.alpha = 1
        view.addSubview(menuView)
        view.bringSubview(toFront: menuView)
        menuView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(64)
            make.height.equalTo(45)
        }
    }
    
    
    func initGuideView(){
        guideView.backgroundColor = UIColor.white
        mainScrollView.addSubview(guideView)
        guideView.snp.makeConstraints { (make) in
            make.top.equalTo(topViewHeight)
            make.left.equalToSuperview()
            make.height.equalTo(360)
            make.width.equalTo(SCREENW)
        }
        
        let topImgView = UIImageView()
        topImgView.image = UIImage.init(named: "route-info-xc")
        guideView.addSubview(topImgView)
        topImgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.height.equalTo(20)
        }
        
        let topLabel = UILabel()
        topLabel.font = UIFont.systemFont(ofSize: 14)
        topLabel.text = "行程概览"
        topLabel.sizeToFit()
        guideView.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topImgView.snp.right).offset(10)
            make.top.equalTo(15)
        }
        
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "RoutrDetailCell", bundle: nil), forCellReuseIdentifier: "cell")
        guideView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(50)
            make.width.equalToSuperview()
            make.bottom.equalTo(-45)
        }
    }
    
    func updateView(){
        let topImageView = mainScrollView.viewWithTag(1) as! UIImageView
        topImageView.kf.setImage(with: URL.init(string:routeDetailModel!.imgs[0].imgResourceUrl))
        var tableViewHeight = 0
        for index in 0...routeDetailModel!.guideDetails.count-1{
             let guideDetail = routeDetailModel!.guideDetails[index]
                tableViewHeight = tableViewHeight + (guideDetail.scenicSpotPostions.count + guideDetail.hotelPostions.count + guideDetail.cateringPostions.count) * 28
        }

        guideView.snp.updateConstraints { (make) in
            make.height.equalTo(95+tableViewHeight)
        }
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH + 95.0 + CGFloat(tableViewHeight) )
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RouteDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if routeDetailModel == nil {
            return 0
        }else{
            return routeDetailModel!.guideDetails.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let guideDetail = routeDetailModel!.guideDetails[section]
        return guideDetail.scenicSpotPostions.count + guideDetail.hotelPostions.count + guideDetail.cateringPostions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RoutrDetailCell
        cell.selectionStyle = .none
        let guideDetail = routeDetailModel!.guideDetails[indexPath.section]
        var firstSectionRow = false
        var model:ScenicSpotPostion?
        if indexPath.row == 0 {
            firstSectionRow = true
        }else{
            firstSectionRow = false
        }
        
        if indexPath.row < guideDetail.scenicSpotPostions.count {
           model = guideDetail.scenicSpotPostions[indexPath.row]
            if indexPath.row == 0 {
                cell.setDate(model: model!,dayNum:guideDetail.dayNumber ,firstSectionRow: firstSectionRow, firstTypeRow: true)
            }
            else{
                cell.setDate(model: model!,dayNum:guideDetail.dayNumber , firstSectionRow: firstSectionRow, firstTypeRow: false)
            }
            return cell
        }
        
        else if guideDetail.scenicSpotPostions.count != 0 && indexPath.row < (guideDetail.scenicSpotPostions.count + guideDetail.cateringPostions.count) {
            model = guideDetail.cateringPostions[indexPath.row - guideDetail.scenicSpotPostions.count]
            if indexPath.row == guideDetail.scenicSpotPostions.count {
                cell.setDate(model: model!,dayNum:guideDetail.dayNumber , firstSectionRow: firstSectionRow, firstTypeRow: true)
            }else{
                cell.setDate(model: model!, dayNum:guideDetail.dayNumber ,firstSectionRow: firstSectionRow, firstTypeRow: false)
            }
            return cell
        }
        
        else if indexPath.row >= guideDetail.scenicSpotPostions.count + guideDetail.cateringPostions.count {
            model = guideDetail.hotelPostions[indexPath.row - (guideDetail.scenicSpotPostions.count + guideDetail.cateringPostions.count)]
            if indexPath.row == guideDetail.scenicSpotPostions.count + guideDetail.cateringPostions.count {
                cell.setDate(model: model!, dayNum:guideDetail.dayNumber ,firstSectionRow: firstSectionRow, firstTypeRow: true)
            }else {
                cell.setDate(model: model!,dayNum:guideDetail.dayNumber , firstSectionRow: firstSectionRow, firstTypeRow: false)
            }
            return cell
        }
        else {
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
    
}
