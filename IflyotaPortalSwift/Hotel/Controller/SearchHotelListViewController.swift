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
    var dateSource = [Hotel]()
    var orderView = HotelSearchOrderView()
    var collectionView:UICollectionView?
    var page = 1
    let refreshView = KRPullLoadView()
    let loadMoreView = KRPullLoadView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        updateListDateWithpage { () -> Void in
            print(2)
        }
        initListView()
        initSearchView()
        initTopBtnView()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:Networking
    func updateListDateWithpage(completion: @escaping ()->Void){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(1)
        LWNetworkTool.shareNetworkTool.searchHotelList(page: page, rows: 5, beginDate: formatter.string(from: startDate!), endDate: formatter.string(from: endDate!), keyWord: keyword ?? "", level: starLevel ?? "", minPrice: minPrice ?? "", maxPrice: maxPrice ?? "") { (items) in
            if self.page == 1 {
                self.dateSource = items
            }else{
                self.dateSource = self.dateSource + items
            }
            completion()
            self.collectionView?.reloadData()
            
            
        }
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
        view.addSubview(collectionView!)
        
        
        refreshView.delegate = self
        collectionView?.addPullLoadableView(refreshView, type: .refresh)
        
        loadMoreView.delegate = self
        collectionView?.addPullLoadableView(loadMoreView, type: .loadMore)
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
            let searchVC = SearchHotelViewController()
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
            self.updateListDateWithpage(completion: {
                
            })
        }
        priceSelectVC.modalPresentationStyle = .overCurrentContext
        present(priceSelectVC, animated: true, completion: nil)
        
    }
    
    @objc func clickRankBtn(){
        UIView.animate(withDuration: 0.4) {
            self.orderView.y = 0
        }
    }
    
    
    deinit {
        collectionView?.removePullLoadableView(refreshView)
        collectionView?.removePullLoadableView(loadMoreView)
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
        cell.titleLabel.text = model.hotelName + "[\(model.hType)]"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension SearchHotelListViewController:KRPullLoadViewDelegate{
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType){
        if type == .loadMore{
            switch state{
            case let .loading(completionHandler):
                DispatchQueue.main.async(execute: {
                    self.page = self.page + 1
                    self.updateListDateWithpage(completion: {
                        completionHandler()
                    })
                })
            default:break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "下拉更多刷新..."
            } else {
                pullLoadView.messageLabel.text = "松手刷新"
            }
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "刷新..."
            DispatchQueue.main.async(execute: {
                self.page =  1
                self.updateListDateWithpage(completion: {
                    completionHandler()
                })
            })
        }
        
    }
}
