//
//  RouteViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/3.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RouteViewController: LWBaseViewController {
    var sort = "LIRecommendNumber"
    var orderView = HotelSearchOrderView()
    var filterView = RouteFilterView()
    var page = 1
    var collectionView:UICollectionView?
    var dateSource = [Route]()
    var isLoading = false
    var total = 0
    var theme:String?

    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "精品线路"

        initRightBarItem()
        initListView()
        initTopBtnView()
        
        updateListDateWithpage()
        // Do any additional setup after loading the view.
    }
    
    //MARK:Networking
    func updateListDateWithpage(){
        isLoading = true
   
        LWNetworkTool.shareNetworkTool.loadRouteList(page: page, rows: 5, keyWord: "", minPrice: "0", maxPrice: "999999",theme:theme ?? "",sort: sort) { (total, items) in
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

    func initRightBarItem(){
        let emptyBar = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        emptyBar.width = -40
        let searchBtn = UIButton()
        searchBtn.addTarget(self, action: #selector(clickSearchBtn), for: UIControlEvents.touchUpInside)
        searchBtn.setImage(UIImage.init(named: "search"), for: UIControlState.normal)
        searchBtn.size = CGSize.init(width: 44, height: 44)
        searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        let searchBar = UIBarButtonItem.init(customView: searchBtn)
        self.navigationItem.rightBarButtonItems = [searchBar,emptyBar]
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
            if sort == "HRecommendedOrder" {
                self.sort = "LIRecommendNumber"
            }else{
                self.sort = sort
            }
            
            self.page = 1
            self.updateListDateWithpage()
        }
        window.addSubview(orderView)
        
        
        filterView.frame = CGRect (x: 0, y: SCREENH, width: SCREENW, height: SCREENH)
        filterView.callBack = {(theme) in
            self.theme = theme
            self.page = 1
            self.updateListDateWithpage()
        }
        window.addSubview(filterView)
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
    
    
    //MARK:Action
    
    @objc func clickFilterBtn(){
        UIView.animate(withDuration: 0.4) {
            self.filterView.y = 0
        }
    }
    
    @objc func clickRankBtn(){
        UIView.animate(withDuration: 0.4) {
            self.orderView.y = 0
        }
    }
    
    @objc func clickSearchBtn(){
        let searchVC = SearchHotelViewController.init(type: .Route)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func refreshData(){
        self.page = 1
        updateListDateWithpage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension RouteViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineListCell", for: indexPath) as! LineListCell
        let model = dateSource[indexPath.row]
        cell.imageView.kf.setImage(with: URL.init(string: model.imgUrl))
        cell.titleLabel.text = "[\(model.tName!)]\(model.lIName!)"
        cell.priceLabel.text = "￥\(model.pLPrice!)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 2 > self.dateSource.count && !self.isLoading && self.total > self.dateSource.count {
            self.page = self.page + 1
            self.updateListDateWithpage()
        }
    }

}
