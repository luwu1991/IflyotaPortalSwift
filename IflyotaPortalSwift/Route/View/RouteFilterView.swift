//
//  RouteFilterView.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/3.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class RouteFilterView: UIView,UIGestureRecognizerDelegate {
    let bottomView = UIView()
    let dataSource = ["全部","乡村游","禅修","休闲养生","亲子游","摄影","户外休闲","婚礼"]
    var selectCell  = 0
    var theme:String?
    var callBack:((_ theme:String) -> ())?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = LWColor(r: 50, g: 50, b: 50, a: 0.5)
        isOpaque = false
        
        let tapOne = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        tapOne.numberOfTapsRequired = 1
        tapOne.numberOfTouchesRequired = 1
        tapOne.delegate = self
        self.addGestureRecognizer(tapOne)
        
        
        initBottonView()
        initCollectionView()
    }
    
    func initBottonView(){
        bottomView.backgroundColor = UIColor.white
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(190)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    func initCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 30)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 15, 0, 15)
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
            make.top.equalTo(0)
            make.height.equalToSuperview()
        }
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint =  touch.location(in: self)
        return !bottomView.frame.contains(touchPoint)
    }
    @objc func tapView(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3) {
            self.y = SCREENH
        }
    }
}

extension RouteFilterView:UICollectionViewDataSource,UICollectionViewDelegate{
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell = indexPath.row
        if indexPath.row > 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! SearchCell
            theme = cell.titlelabel.text
        }else{
            theme = nil
        }
        collectionView.reloadData()
        if callBack != nil {
            callBack!(theme ?? "")
        }
        UIView.animate(withDuration: 0.3) {
            self.y = SCREENH
        }
    }
    
}
