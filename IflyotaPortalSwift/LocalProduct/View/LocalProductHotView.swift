//
//  LocalProductHotView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/10.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LocalProductHotView: UIView {

    public var scrollView:UIScrollView
    public var collectionView:UICollectionView?
    var datas:[LocalProduct]
    required init(coder aDecoder:NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    init(frame: CGRect,data:[LocalProduct]) {
        self.scrollView = UIScrollView()
        self.datas = data
        super.init(frame: frame)
        setLayout()
        setCollectionView()
    }
    
    func reloadDate(_ data:[LocalProduct]){
        self.datas = data
        collectionView?.reloadData()
    }
    
    func setLayout(){
        backgroundColor = UIColor.white
        
        let tagImg = UIImageView()
        tagImg.image = UIImage.init(named: "title-bg")
        tagImg.frame = CGRect.init(x: 15, y: 10, width: 10, height: 20)
        addSubview(tagImg)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect (x: 35, y: 13, width: 120, height: 20)
        titleLabel.text = "本周热卖"
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.yellow
        titleLabel.sizeToFit()
        titleLabel.height = 14
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        
        addSubview(titleLabel)
        
        
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
        collectionView?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(40)
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.height).inset(20)
        })
    }
    
    
}

extension LocalProductHotView:UICollectionViewDelegate,UICollectionViewDataSource{
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
        
        cell.titleLabel.text = model.specialtyName
        
        cell.subTitle.text = "￥\(model.minPrice!)"
        let priceText = "\(model.salesNum!)人购买"
        let range = NSRange.init(location: 0, length: String(model.salesNum!).count)
        let attributedText = NSMutableAttributedString(string:priceText)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,value:ThemeColor(), range: range)
        cell.priceLabel.attributedText = attributedText
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
