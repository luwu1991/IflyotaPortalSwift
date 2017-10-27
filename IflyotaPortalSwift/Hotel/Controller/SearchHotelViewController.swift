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
    var dataSource:[SearchHotelTags] = [SearchHotelTags]()
    var tagCollection:UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        initSearchView()
        initTagView()
        LWNetworkTool.shareNetworkTool.loadHotelTagGroup(groupNames: "", groupChannel: "安卓客户端", groupPages: "酒店搜索", groupModules: "搜索", groupTypes: "酒店", imgType: "") { (items) in
            self.dataSource = items
            self.tagCollection?.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func initTagView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 180, height: 30)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        flowLayout.headerReferenceSize = CGSize(width: SCREENW, height: 60)
        tagCollection = UICollectionView.init(frame: CGRect (x: 0, y: 64, width: SCREENW, height: SCREENH - 64), collectionViewLayout: flowLayout)
        tagCollection?.backgroundColor = UIColor.white
        tagCollection?.delegate = self
        tagCollection?.dataSource = self
        tagCollection?.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
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
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let tag = dataSource[indexPath.section].tags[indexPath.row]
        cell.titlelabel.text = tag.tName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HotelSearchHeaderView
        let tags = dataSource[indexPath.section]
        header.imageView.kf.setImage(with: URL(string: tags.imageUrl))
        header.titleLabel.text = tags.groupName
        return header
        
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

