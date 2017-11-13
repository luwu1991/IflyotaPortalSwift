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
    let scrolView = UIScrollView()
    let topImageView = UIImageView()
    let nameLabel = UILabel()
    let introduceView = UIView()
    let dateView = UIView()
    var hotelInfo:HotelInfo?
    var rooms:[HotelRoom] = [HotelRoom]()
    let tableView = UITableView.init(frame: CGRect (x: 0, y: 0, width:0, height: 0), style: .plain)
    let headerView = UIView()
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = hotelInfo?.hName
        formatter.dateFormat = "yyy-MM-dd"
        LWNetworkTool.shareNetworkTool.loadHotelDetailWithIID(iid!, startDate: formatter.string(from: startDate), endDate: formatter.string(from: endDate)) { (hotelInfo,items) in
            self.hotelInfo = hotelInfo
            self.rooms = items
           
            self.updateView()
        }
        
        scrolView.backgroundColor = self.view.backgroundColor
        scrolView.frame = CGRect (x: 0, y: -64, width: SCREENW, height: SCREENH+64)
        scrolView.contentSize = CGSize (width: SCREENW, height: SCREENH+471)
        scrolView.contentOffset = CGPoint (x: 0, y: 0)
        scrolView.showsHorizontalScrollIndicator = false
        scrolView.showsVerticalScrollIndicator = false
        scrolView.delegate = self
        view.addSubview(scrolView)
        initTopImageView()
        initIntroduceView()
        initDateView()
        initRoomListView()
        initHeaderView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.titleView?.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setNeedsNavigationBackground(alpha:0.0)
        self.navigationItem.titleView?.isHidden = false
        self.navigationItem.titleView?.alpha = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNeedsNavigationBackground(alpha:1.0)
        self.navigationItem.titleView?.alpha = 1
    }
    

    func initTopImageView(){
        topImageView.contentMode = .scaleAspectFill
        scrolView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENW*(54/75))
        }
        
        let nameView = UIView()
        nameView.backgroundColor = UIColor.white
        scrolView.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(SCREENW)
            make.top.equalTo(topImageView.snp.bottom)
            make.height.equalTo(35)
        }
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.tag = 1
        nameView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func initIntroduceView(){
        introduceView.backgroundColor = UIColor.white
        scrolView.addSubview(introduceView)
        introduceView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(SCREENW)
            make.top.equalTo(topImageView.snp.bottom).offset(45)
            make.height.equalTo(90)
        }
        
        let topLabel = UILabel()
        topLabel.font = UIFont.systemFont(ofSize: 14)
        topLabel.tag  = 1
        introduceView.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.right.equalTo(30)
        }
        let rightImg1 = UIImageView()
        rightImg1.image = UIImage (named: "right")
        introduceView.addSubview(rightImg1)
        rightImg1.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        
        let bottomLabel = UILabel()
        bottomLabel.font = UIFont.systemFont(ofSize: 14)
        bottomLabel.tag = 2
        bottomLabel.text = "酒店介绍"
        introduceView.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.left.equalTo(15)
            make.right.equalTo(30)
        }
        
        let rightImg2 = UIImageView()
        rightImg2.image = UIImage (named: "right")
        introduceView.addSubview(rightImg2)
        rightImg2.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        let line = UIView()
        line.backgroundColor = garyColor
        introduceView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func initDateView(){
        dateView.backgroundColor = UIColor.white
        scrolView.addSubview(dateView)
        dateView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(SCREENW)
            make.top.equalTo(introduceView.snp.bottom).offset(10)
            make.height.equalTo(55)
        }
        
        let leftImage = UIImageView()
        leftImage.image = UIImage (named: "candle")
        dateView.addSubview(leftImage)
        leftImage.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        let titlaLabel = UILabel()
        titlaLabel.font = UIFont.systemFont(ofSize: 14)
        titlaLabel.text = "入离店日期"
        dateView.addSubview(titlaLabel)
        titlaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(5)
        }
        
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = ThemeColor()
        formatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = "\(formatter.string(from: startDate))-\(formatter.string(from: endDate))"
        dateView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(titlaLabel.snp.bottom).offset(10)
        }
        
        
        let daysLabel = UILabel()
        daysLabel.font = UIFont.systemFont(ofSize: 14)
        daysLabel.backgroundColor = ThemeColor()
        daysLabel.textColor = UIColor.white
        daysLabel.textAlignment = .center
        daysLabel.text = "共\(Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!)天"
        daysLabel.layer.cornerRadius = 10
        daysLabel.layer.masksToBounds = true
        daysLabel.sizeToFit()
        dateView.addSubview(daysLabel)
        daysLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-40)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        
        let rightImage = UIImageView()
        rightImage.image = UIImage(named:"right")
        dateView.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    func initRoomListView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        tableView.register(UINib.init(nibName: "RoomCell", bundle: nil), forCellReuseIdentifier: "cell")
        scrolView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalTo(SCREENW)
            make.height.equalTo(SCREENH)
            make.top.equalTo(472)
        }
    }
    
    func initHeaderView(){
        headerView.backgroundColor = UIColor.white
        let titlelabel = UILabel()
        titlelabel.font = UIFont.systemFont(ofSize: 14)
        titlelabel.text = "*请提前24小时预约"
        headerView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        let line = UIView()
        line.backgroundColor = LWColor(r: 235, g: 235, b: 235, a: 1.0)
        headerView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(-1)
            make.height.equalTo(1)
        }
    }
    
    //MARK:action
    func updateView(){
        topImageView.kf.setImage(with: URL(string: self.hotelInfo!.resourceUrl))
        nameLabel.text = "\(self.hotelInfo!.hName!)[\(self.hotelInfo!.hType!)]"
        let topLabel = introduceView.viewWithTag(1) as! UILabel
        topLabel.text = hotelInfo?.hAddress
        let newHeight = 471 + 45 + rooms.count * 100
        if CGFloat(newHeight) > (SCREENH + 64) {
            self.scrolView.contentSize = CGSize (width: SCREENW, height: CGFloat(471+45+rooms.count*100))
        }
        else{
            self.scrolView.contentSize = CGSize (width: SCREENW, height: SCREENH+64)
        }
        tableView.snp.updateConstraints { (make) in
            make.height.equalTo(newHeight - 471)
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HotelDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RoomCell
        let model = self.rooms[indexPath.row]
        cell.setDate(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}

extension HotelDetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxAlphaOffset:CGFloat = 100;
        let offset:CGFloat = scrollView.contentOffset.y;
        let alpha = offset / maxAlphaOffset;
        self.navigationController?.setNeedsNavigationBackground(alpha:alpha)
    }
}


