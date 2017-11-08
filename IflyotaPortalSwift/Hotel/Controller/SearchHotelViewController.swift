//
//  SearchHotelViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/27.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
typealias SendSearchTitleCallBack = (_ searchTitle:String) -> ()

enum SearchType {
    case Hotel
    case Route
    case ScenicSpot
}

class SearchHotelViewController: LWBaseViewController {
    var searchVC:UISearchController?
    var hotelTags:[SearchHotelTags] = [SearchHotelTags]()
    var searchHistory = [HistoryRecord]()
    var dataSource = Array(repeating: [Any](), count: 2)
    var tagCollection:UICollectionView?
    var searchTitle:String?
    var searchTitleCallBack:SendSearchTitleCallBack?
    var type = SearchType.Hotel
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     init(type:SearchType){
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        initSearchView()
        initTagView()
       
        loadNetworking()
        // Do any additional setup after loading the view.
    }
    //MARK:NetWorking
    func loadNetworking(){
        if self.type == .Hotel {
            LWNetworkTool.shareNetworkTool.loadHotelTagGroup(groupNames: "", groupChannel: "安卓客户端", groupPages: "酒店搜索", groupModules: "搜索", groupTypes: "酒店", imgType: "") { (items) in
                self.dataSource[0] = items
                self.tagCollection?.reloadData()
                self.tagCollection?.collectionViewLayout.invalidateLayout()
            }
            if UserInfo.shareUserInfo.userID != nil {
                LWNetworkTool.shareNetworkTool.loadHistoryRecords(userID: UserInfo.shareUserInfo.userID!, type: "酒店") { (items) in
                    self.dataSource[1] = items
                    self.tagCollection?.reloadData()
                    self.tagCollection?.collectionViewLayout.invalidateLayout()
                }
            }
        }
        
        if self.type == .Route {
            LWNetworkTool.shareNetworkTool.loadKeyWordByType(type: "线路", finished: { (items) in
                self.dataSource[0] = items
                self.tagCollection?.reloadData()
                self.tagCollection?.collectionViewLayout.invalidateLayout()
            })
            
            if UserInfo.shareUserInfo.userID != nil {
                LWNetworkTool.shareNetworkTool.loadHistoryRecords(userID: UserInfo.shareUserInfo.userID!, type: "线路") { (items) in
                    self.dataSource[1] = items
                    self.tagCollection?.reloadData()
                    self.tagCollection?.collectionViewLayout.invalidateLayout()
                }
            }
        }
        
        if self.type == .ScenicSpot {
            LWNetworkTool.shareNetworkTool.loadKeyWordByType(type: "景点", finished: { (items) in
                self.dataSource[0] = items
                self.tagCollection?.reloadData()
                self.tagCollection?.collectionViewLayout.invalidateLayout()
            })
            
            if UserInfo.shareUserInfo.userID != nil {
                LWNetworkTool.shareNetworkTool.loadHistoryRecords(userID: UserInfo.shareUserInfo.userID!, type: "景点") { (items) in
                    self.dataSource[1] = items
                    self.tagCollection?.reloadData()
                    self.tagCollection?.collectionViewLayout.invalidateLayout()
                }
            }
        }
    }
    
    
    func initTagView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 30)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        flowLayout.headerReferenceSize = CGSize(width: SCREENW, height: 60)
        tagCollection = UICollectionView.init(frame: CGRect (x: 0, y: 64, width: SCREENW, height: SCREENH - 64), collectionViewLayout: flowLayout)
        tagCollection?.backgroundColor = UIColor.white
        tagCollection?.delegate = self
        tagCollection?.dataSource = self
        tagCollection?.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        tagCollection?.register(HotelSearchHistoryCell.self, forCellWithReuseIdentifier: "RecordCell")
        tagCollection?.register(UINib.init(nibName: "HotelSearchHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        view.addSubview(tagCollection!)
    }
    
    
    func initSearchView() {
        searchVC = UISearchController(searchResultsController: nil)
        searchVC?.hidesNavigationBarDuringPresentation = false
        searchVC?.dimsBackgroundDuringPresentation = false
        if type == .Hotel {
            searchVC?.searchBar.placeholder = "酒店名/地址/商标"
        }
        
        if type == .Route {
            searchVC?.searchBar.placeholder = "搜索线路"
        }
        
        if type == .ScenicSpot {
            searchVC?.searchBar.placeholder = "搜索景点"
        }
        var backImg = UIImage.imageWithColor(color: garyColor, size: CGSize(width: 28.0, height: 28.0))
        backImg = UIImage.roundedImage(image: backImg, cornerRadius: 8)
        searchVC?.searchBar.setSearchFieldBackgroundImage(backImg, for: UIControlState.normal)
        searchVC?.searchBar.searchTextPositionAdjustment = UIOffsetMake(8.0, 0)
        searchVC?.searchBar.setValue("清除", forKey:"_cancelButtonText")
        searchVC?.searchBar.tintColor = UIColor.black
        searchVC?.searchBar.delegate = self
        self.navigationItem.titleView = searchVC?.searchBar
        if #available(iOS 11.0, *) {
            searchVC?.searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
}

extension SearchHotelViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch type {
        case .Hotel:
            return dataSource[0].count + (dataSource[1].count == 0 ? 0 : 1)
        case .Route,.ScenicSpot:
            return (dataSource[0].count == 0 ? 0 : 1) + (dataSource[1].count == 0 ? 0 : 1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        switch type {
        case .Hotel:
            if dataSource[0].count < (section + 1) {
                return dataSource[1].count
            }else{
                let items = dataSource[0] as! [SearchHotelTags]
                return items[section].tags.count
            }
        case .Route,.ScenicSpot:
            return dataSource[section].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.section)
        
        switch type {
        case .Hotel:
            if dataSource[0].count < (indexPath.section + 1) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as! HotelSearchHistoryCell
                let record = dataSource[1][indexPath.row] as! HistoryRecord
                cell.titleLabel.text = record.operateCentent
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
                    let tags = dataSource[0] as! [SearchHotelTags]
                    let tag = tags[indexPath.section].tags[indexPath.row]
                    cell.titlelabel.text = tag.tName
                return cell
            }
        case .Route,.ScenicSpot:
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
                    let tags = dataSource[0] as! [RouteKeyWord]
                    let keyword = tags[indexPath.row]
                    cell.titlelabel.text = keyword.keyword
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as! HotelSearchHistoryCell
                let record = dataSource[1][indexPath.row] as! HistoryRecord
                cell.titleLabel.text = record.operateCentent
                return cell
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch type {
        case .Hotel:
            if dataSource[0].count < (indexPath.section + 1){
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HotelSearchHeaderView
                header.imageView.image = UIImage(named:"history-icon")
                header.titleLabel.text = "搜索历史记录"
                return header
                
            }else{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HotelSearchHeaderView

                let tags = dataSource[0] as! [SearchHotelTags]
                header.imageView.kf.setImage(with: URL(string: tags[indexPath.section].imageUrl))
                header.titleLabel.text = tags[indexPath.section].groupName

                return header
            }
        case .Route,.ScenicSpot:
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HotelSearchHeaderView
                header.imageView.image = UIImage(named:"hot-icon")
                header.titleLabel.text = "热门关键词"
                return header
            }else{
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HotelSearchHeaderView
                header.imageView.image = UIImage(named:"history-icon")
                header.titleLabel.text = "搜索历史记录"
                return header
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataSource[0].count < (indexPath.section + 1) {
            let cell = collectionView.cellForItem(at: indexPath) as! HotelSearchHistoryCell
            if searchTitleCallBack != nil {
                searchTitleCallBack!(cell.titleLabel.text!)
            }
            navigationController?.popViewController(animated: true)
        }else{
            let cell = collectionView.cellForItem(at: indexPath) as! SearchCell
            if searchTitleCallBack != nil {
                searchTitleCallBack!(cell.titlelabel.text!)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}

extension SearchHotelViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        var type = "酒店"
        switch self.type {
        case .Hotel:
            type = "酒店"
        case .Route:
            type = "线路"
        case .ScenicSpot:
            type = "景点"
        }
        LWNetworkTool.shareNetworkTool.addHistoryRecord(ObjectType: type, OperateCentent: searchBar.text ?? "", UserIID: UserInfo.shareUserInfo.userID ?? "")
        if searchTitleCallBack != nil {
            searchTitleCallBack!(searchBar.text!)
        }
        navigationController?.popViewController(animated: true)
    }
    

}

