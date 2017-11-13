//
//  ScenicSpotView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/21.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class ScenicSpotView: UIView {

    public var scrollView:UIScrollView
    public var collectionView:UICollectionView?
    var datas:[ScenicSpotModel]
    var clickItem:( (_ item:ScenicSpotModel) -> ())?
    required init(coder aDecoder:NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    init(frame: CGRect,data:[ScenicSpotModel]) {
        self.scrollView = UIScrollView()
        self.datas = data
        super.init(frame: frame)
        setLayout()
        setCollectionView()
    }
    
    func setLayout(){
        backgroundColor = UIColor.white
        let titleLabel = UILabel()
        titleLabel.frame = CGRect (x: 10, y: 10, width: 120, height: 20)
        titleLabel.text = "当季热门景点"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        let moreBtn = UIButton()
        moreBtn.frame = CGRect (x: SCREENW - 50, y: 10, width: 40, height: 20)
        moreBtn.setTitle("更多", for: UIControlState.normal)
        moreBtn.setTitleColor(LWColor(r: 186, g: 186, b: 186, a: 186), for: UIControlState.normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addSubview(titleLabel)
        addSubview(moreBtn)
        
        scrollView.frame = CGRect (x: 0, y: 40, width: self.width, height: self.height - 28)
        
        scrollView.backgroundColor = UIColor.white
        addSubview(scrollView)
    }
    
    func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 160, height: 132)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView (frame: CGRect (x: 0, y: 40, width: self.width, height: self.height - 28), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UINib(nibName: "ScenicSpotItemView", bundle: nil), forCellWithReuseIdentifier: "ScenicSpotItemView")
        addSubview(collectionView!)
    }
    
  
}

extension ScenicSpotView:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScenicSpotItemView", for: indexPath) as! ScenicSpotItemView
        let model = datas[indexPath.row]
        cell.imageView.kf.setImage(with: URL (string: model.imgUrl))
        
        cell.titleLabel.text = model.scenicName
        
        cell.subTitle.text = model.subhead
        
        cell.priceLabel.text = "￥"+model.scenicTicketPriceRange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = datas[indexPath.row]
        if clickItem != nil {
            clickItem!(model)
        }
    }
    
}
