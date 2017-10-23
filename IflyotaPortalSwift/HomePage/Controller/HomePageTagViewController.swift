//
//  HomePageTagViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/23.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class HomePageTagViewController: LWBaseViewController {

    var tag:String?
    var items = [LineListItemModel]()
    var collectionView:UICollectionView?
    weak var mainScrollView:UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 355, height: 200)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionView = UICollectionView (frame: CGRect (x: 0, y: 0, width: SCREENW, height:SCREENH - 40 - 20 - 44), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = garyColor
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isScrollEnabled = false
        collectionView?.register(UINib.init(nibName: "LineListCell", bundle: nil), forCellWithReuseIdentifier: "LineListCell")
        view.addSubview(collectionView!)
        
        LWNetworkTool.shareNetworkTool.loadHomePageLineList(condition:tag!) { (items) in
            self.items = items
            if CGFloat(items.count * 200) > SCREENH - 40 {
//                let view = self.view.superview as! UIScrollView
//                view.height = CGFloat(items.count * 200)
                self.collectionView?.height = CGFloat(items.count * 200) + 44
            }
            self.collectionView?.reloadData()
        }
        // Do any additional setup after loading the view.
    }

}

extension HomePageTagViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineListCell", for: indexPath) as! LineListCell
        let model = items[indexPath.row]
        cell.imageView.kf.setImage(with: URL (string: model.imgUrl))
        cell.titleLabel.text = "["+model.tName+"]"+model.lIName
        cell.subTitleLabel.text = model.tDescription
        cell.priceLabel.text = "￥"+model.pLPrice
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
