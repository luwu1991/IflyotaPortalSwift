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
    let priceInstr = UIView()
    let reservationNotice = UIView()
    let titleLabel = UILabel()
    var guideViewY:CGFloat = 0
    var priceInstrY:CGFloat = 0
    var reservationNoticeY:CGFloat = 0
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 200), style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = model?.lIName
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .black)
        titleLabel.sizeToFit()
        titleLabel.alpha = 0.0
        self.navigationItem.titleView = titleLabel
        self.automaticallyAdjustsScrollViewInsets = true
        mainScrollView.backgroundColor = view.backgroundColor
        mainScrollView.frame = CGRect.init(x: 0, y: -64, width: SCREENW, height: SCREENH + 64)
        mainScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
        
        initTopView()
        initMenuView()
        initGuideView()
        initPriceInstrView()
        initReservationNoticeView()
        netWorking()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.titleView?.isHidden = true
  
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNeedsNavigationBackground(alpha:0.0)
         self.navigationItem.titleView?.isHidden = false
        self.navigationItem.titleView?.alpha = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNeedsNavigationBackground(alpha:1.0)
        self.navigationItem.titleView?.alpha = 1
    }

    override func viewDidLayoutSubviews() {
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: reservationNotice.y+reservationNotice.height)
        guideViewY = guideView.y
        priceInstrY = priceInstr.y
        reservationNoticeY = reservationNotice.y
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
        menuView.alpha = 0
        view.addSubview(menuView)
        view.bringSubview(toFront: menuView)
        menuView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(64)
            make.height.equalTo(45)
        }
        let btnSpace = (SCREENW - 90 - 3*60)/2
        let titles = ["日行程","费用说明","预定须知"]
        for index in 1...3 {
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(titles[index - 1], for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.setTitleColor(ThemeColor(), for: UIControlState.selected)
            menuView.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.left.equalTo(45 + CGFloat(index - 1) * (60+btnSpace))
                make.height.equalToSuperview()
                make.width.equalTo(60)
                make.top.equalToSuperview()
            })
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
    
    func initPriceInstrView(){
        priceInstr.backgroundColor = UIColor.white
        mainScrollView.addSubview(priceInstr)
        priceInstr.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.top.equalTo(guideView.snp.bottom).offset(10)
//            make.height.equalTo(500)
        }
        
        let titleImage = UIImageView()
        titleImage.image = UIImage.init(named: "route-info-fy")
        priceInstr.addSubview(titleImage)
        titleImage.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "费用说明"
        titleLabel.sizeToFit()
        priceInstr.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleImage.snp.right).offset(10)
            make.top.equalTo(10)
        }
        
        let contentLabel = UILabel()
        contentLabel.tag = 1
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.sizeToFit()
        priceInstr.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(0)
            make.top.equalTo(60)
        }
    }
    
    
    func initReservationNoticeView(){
        reservationNotice.backgroundColor = UIColor.white
        mainScrollView.addSubview(reservationNotice)
        reservationNotice.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.top.equalTo(priceInstr.snp.bottom).offset(10)
        }
        
        let titleImage = UIImageView()
        titleImage.image = UIImage.init(named: "route-info-ydxz")
        reservationNotice.addSubview(titleImage)
        titleImage.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "预定须知"
        titleLabel.sizeToFit()
        reservationNotice.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleImage.snp.right).offset(10)
            make.top.equalTo(10)
        }
        let contentLabel = UILabel()
        contentLabel.tag = 1
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.sizeToFit()
        reservationNotice.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(0)
            make.top.equalTo(60)
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
        
        
        let contentLabel = priceInstr.viewWithTag(1) as! UILabel
        contentLabel.attributedText = stringFromHtml(string: routeDetailModel!.lIIllustration)
        
        let notesLabel = reservationNotice.viewWithTag(1) as! UILabel
        notesLabel.attributedText = stringFromHtml(string: routeDetailModel!.lINotes)
        mainScrollView.layoutIfNeeded()
        priceInstr.layoutIfNeeded()
        reservationNotice.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    
    func stringFromHtml(string: String) -> NSAttributedString? {
        guard let data = string.data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
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

extension RouteDetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxAlphaOffset:CGFloat = SCREENW*540/755 - 64*2 - 45;
        let offset:CGFloat = scrollView.contentOffset.y;
        let alpha = offset / maxAlphaOffset;
        menuView.alpha = alpha
        self.navigationController?.setNeedsNavigationBackground(alpha:alpha)
        titleLabel.alpha = alpha
    }

}
