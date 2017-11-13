//
//  SearchHotelListViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/30.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

import KRPullLoader

class SearchHotelListViewController: LWBaseViewController {
    let searchView = Bundle.main.loadNibNamed("HotelScearchView", owner: nil, options: nil)?.first as! HotelSearchView
    var startDate:Date?
    var endDate:Date?
    var keyword:String?
    var minPrice:String?
    var maxPrice:String?
    var starLevel:String?
    var sort = "HRecommendedOrder"
    var sendValueCallBack:((_ starLevel:String?,_ minPrice:String?,_ maxPrice:String?,_ startDate:Date?,_ endDate:Date?,_ keyword:String?) -> ())?
    var dateSource = [Hotel]()
    var orderView = HotelSearchOrderView()
    var collectionView:UICollectionView?
    var page = 1
    var isLoading = false
    var total = 0
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateListDateWithpage()
        initListView()
        initSearchView()
        initTopBtnView()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        if self.sendValueCallBack != nil{
            sendValueCallBack!(starLevel,minPrice,maxPrice,startDate,endDate,keyword)
        }
    }
    
    //MARK:Networking
    func updateListDateWithpage(){
        isLoading = true
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        LWNetworkTool.shareNetworkTool.searchHotelList(page: page, rows: 5, beginDate: formatter.string(from: startDate!), endDate: formatter.string(from: endDate!), keyWord: keyword ?? "", level: starLevel ?? "", minPrice: minPrice ?? "", maxPrice: maxPrice ?? "",sort: sort) { (total,items) in
            if self.page == 1 {
                self.dateSource = items
            }else{
                self.dateSource = self.dateSource + items
            }
            self.isLoading = false
            self.total = total
            self.refreshControl.endRefreshing()
            self.collectionView?.reloadData()
            
            
        }
    }
    
    @objc func refreshData(){
        self.page = 1
        updateListDateWithpage()
    }
    
    func initListView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: SCREENW - 20, height: 200)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionView = UICollectionView (frame: CGRect (x: 0, y: 64, width: SCREENW, height:SCREENH - 64), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = garyColor
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.contentInset = UIEdgeInsetsMake(50,0, 0,0)
        collectionView?.register(UINib.init(nibName: "LineListCell", bundle: nil), forCellWithReuseIdentifier: "LineListCell")
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        view.addSubview(collectionView!)
        
    }
    
    func initSearchView() {
        
        searchView.frame = CGRect (x: 0, y: 0, width: SCREENW - 100, height: 30)
        let formate = DateFormatter()
        formate.dateFormat = "MM-dd"
        searchView.startDate.text = "住 " + formate.string(from: startDate!)
        searchView.endDate.text = "离 " + formate.string(from: endDate!)
        if keyword != nil {
            searchView.keyword.text = keyword
        }
        searchView.clickDate = {[weak self] in
            let calenVC = CalendarViewController()
            calenVC.dateCallBack = {(startDate,endDate) in
                self?.startDate = startDate
                self?.endDate = endDate
                self?.setDateText()
            }
            calenVC.startDate = self?.startDate
            calenVC.endDate = self?.endDate
            self?.navigationController?.pushViewController(calenVC, animated: true)
        }
        
        searchView.clickKeyword = { [weak self] in
            let searchVC = SearchHotelViewController.init(type: .Hotel)
            searchVC.searchTitleCallBack = {(searchTitle) in
                self?.keyword = searchTitle
                self?.searchView.keyword.text = searchTitle
            }
            self?.navigationController?.pushViewController(searchVC, animated: true)
        }
        self.navigationItem.titleView = searchView
    }
    
    func initTopBtnView(){
        let btnW = (SCREENW - 20 - 2)/2
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.white
        leftBtn.setImage(UIImage (named: "filter_icon"), for: UIControlState.normal)
        leftBtn.setTitle("筛选", for: UIControlState.normal)
        leftBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        let path = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: btnW, height: 40), byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: 4, height:4))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = CGRect (x: 0, y: 0, width: btnW, height: 40)
        maskLayer1.path = path.cgPath
        leftBtn.layer.mask = maskLayer1
        leftBtn.addTarget(self, action: #selector(clickFilterBtn), for: UIControlEvents.touchUpInside)
        view.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(69)
            make.width.equalTo(btnW)
            make.height.equalTo(40)
        }
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.white
        rightBtn.setImage(UIImage (named: "rank_icon"), for: UIControlState.normal)
        rightBtn.setTitle("排序", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        let path2 = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: btnW, height: 40), byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: 4, height:4))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = CGRect (x: 0, y: 0, width: btnW, height: 40)
        maskLayer2.path = path2.cgPath
        rightBtn.layer.mask = maskLayer2
        rightBtn.addTarget(self, action: #selector(clickRankBtn), for: UIControlEvents.touchUpInside)
        view.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(69)
            make.width.equalTo(btnW)
            make.height.equalTo(40)
        }
        let window = UIApplication.shared.keyWindow!
        orderView.frame = CGRect (x: 0, y: SCREENH, width: SCREENW, height: SCREENH)
        orderView.clickBtnCallBack = {(sort) in
            self.sort = sort
            self.page = 1
            self.updateListDateWithpage()
        }
        window.addSubview(orderView)
    }
    
    func setDateText(){
        let formate = DateFormatter()
        formate.dateFormat = "MM-dd"
        searchView.startDate.text = "住 " + formate.string(from: startDate!)
        searchView.endDate.text = "离 " + formate.string(from: endDate!)
    }
    
    
    //MARK: Action
    @objc func clickFilterBtn(){
        let priceSelectVC = SelectPriceViewController()
        priceSelectVC.starLevel = self.starLevel
        priceSelectVC.minPrice = self.minPrice
        priceSelectVC.maxPrice = self.maxPrice
        priceSelectVC.sendValueCallBack = { (startLevel,minValue,maxValue) in
            self.starLevel = startLevel
            self.minPrice = minValue
            self.maxPrice = maxValue
            self.page = 1
            
            self.updateListDateWithpage()
        }
        priceSelectVC.modalPresentationStyle = .overCurrentContext
        present(priceSelectVC, animated: true, completion: nil)
        
    }
    
    @objc func clickRankBtn(){
        UIView.animate(withDuration: 0.4) {
            self.orderView.y = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SearchHotelListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineListCell", for: indexPath) as! LineListCell
        let model = dateSource[indexPath.row]
        cell.imageView.kf.setImage(with: URL (string: model.imgUrl))
        cell.titleLabel.text = model.hotelName + "[\(model.hType!)]"
        cell.subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        let priceText = "￥"+model.priceRange+" 起"
        let range =  NSRange.init(location: 0, length: model.priceRange.count+1)
        let lastRange = NSRange.init(location: model.priceRange.count+1, length: 2)
        let attributedText = NSMutableAttributedString(string: priceText)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,value:ThemeColor(), range: range)
        attributedText.addAttribute(NSAttributedStringKey.font,value:UIFont.systemFont(ofSize: 12) , range: lastRange)
        cell.subTitleLabel.attributedText = attributedText
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 2 > self.dateSource.count && !self.isLoading && self.total > self.dateSource.count {
            self.page = self.page + 1
            self.updateListDateWithpage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dateSource[indexPath.row]
        let hotelDetailVC = HotelDetailViewController()
        hotelDetailVC.startDate = startDate!
        hotelDetailVC.endDate = endDate!
        hotelDetailVC.iid = model.hotelIID
        self.navigationController?.pushViewController(hotelDetailVC, animated: true)
    }
}


