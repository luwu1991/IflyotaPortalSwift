//
//  SearchHotelViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/27.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class SearchHotelViewController: LWBaseViewController {
    var searchVC:UISearchController?
    var hotelTags:[SearchHotelTags] = [SearchHotelTags]()
    var searchHistory = [HistoryRecord]()
    var dataSource = Array(repeating: [Any](), count: 2)
    var tagCollection:UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        initSearchView()
        initTagView()
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
        
        // Do any additional setup after loading the view.
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
        searchVC?.searchBar.placeholder = "酒店名/地址/商标"
        var backImg = UIImage.imageWithColor(color: garyColor, size: CGSize(width: 28.0, height: 28.0))
        backImg = UIImage.roundedImage(image: backImg, cornerRadius: 8)
        searchVC?.searchBar.setSearchFieldBackgroundImage(backImg, for: UIControlState.normal)
        searchVC?.searchBar.searchTextPositionAdjustment = UIOffsetMake(8.0, 0)
        searchVC?.searchBar.setValue("清除", forKey:"_cancelButtonText")
        searchVC?.searchBar.tintColor = UIColor.black
        searchVC?.searchBar.delegate = self
        self.navigationItem.titleView = searchVC?.searchBar
    }
}

extension SearchHotelViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource[0].count + (dataSource[1].count == 0 ? 0 : 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if dataSource[0].count < (section + 1) {
            return dataSource[1].count
        }else{
            let items = dataSource[0] as! [SearchHotelTags]
            return items[section].tags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.section)
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(collectionView)
    }
}

extension SearchHotelViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        LWNetworkTool.shareNetworkTool.addHistoryRecord(ObjectType: "酒店", OperateCentent: searchBar.text ?? "", UserIID: UserInfo.shareUserInfo.userID ?? "")
    }
    
    
}

