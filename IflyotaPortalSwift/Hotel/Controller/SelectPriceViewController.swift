//
//  SelectPriceViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/29.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class SelectPriceViewController: UIViewController,UIGestureRecognizerDelegate {
    let bottomView = UIView()
    let dataSource = ["不限","名宿客栈","经济连锁","三星级","四星级","五星级"]
    var selectCell  = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LWColor(r: 50, g: 50, b: 50, a: 0.5)
        view.isOpaque = false
        
        initBottonView()
        initStarView()
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        tapOne.delegate = self
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
        bottomView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(10)
            make.height.equalTo(120)
        }
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint =  touch.location(in: self.view)
        return !bottomView.frame.contains(touchPoint)
    }
    @objc func tapView(_ sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SelectPriceViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.titlelabel.text = dataSource[indexPath.row]
        if indexPath.row == selectCell{
            cell.isSelected = true
        }
        if cell.isSelected {
            cell.backgroundColor = ThemeColor()
            cell.titlelabel.textColor = UIColor.white
        }else{
            cell.backgroundColor = LWColor(r: 242, g: 242, b: 242, a: 1.0)
            cell.titlelabel.textColor = UIColor.black
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastSelectIndexPath = IndexPath.init(row: selectCell, section: 0)
        selectCell = indexPath.row
        collectionView.reloadData()
    }
}
