//
//  SelectPriceViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/29.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class SelectPriceViewController: UIViewController {
    let bottomView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LWColor(r: 50, g: 50, b: 50, a: 0.5)
        view.isOpaque = false
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapView))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapOne)
    }
    
    
    func initBottonView(){
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func initStarView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 30)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        flowLayout.headerReferenceSize = CGSize(width: SCREENW, height: 30)
        let collectionView = UICollectionView.init(frame: CGRect (x: 0, y: 15, width: SCREENW, height: 120), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        collectionView.register(UINib.init(nibName: "SelectPriceHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(10)
            make.height.equalTo(120)
        }
    }
    
    
    
    @objc func tapView(){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SelectPriceViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
//        let tags = dataSource[0] as! [SearchHotelTags]
//        let tag = tags[indexPath.section].tags[indexPath.row]
        cell.titlelabel.text = "adf"
        return cell
    }
    
}
