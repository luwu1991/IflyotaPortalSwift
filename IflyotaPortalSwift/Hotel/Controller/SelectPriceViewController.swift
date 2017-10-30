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
    var starLevel:String?
    var minPrice:String?
    var maxPrice:String?
    var sendValueCallBack:((_ starLevel:String?, _ minPrice:String?,_ maxPrice:String?) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LWColor(r: 50, g: 50, b: 50, a: 0.5)
        view.isOpaque = false
        
        initBottonView()
        initStarView()
        initRangSilderView()
        
        if starLevel != nil {
            
            selectCell = dataSource.index(of: starLevel!)!
        }
        
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
        
        let btn = UIButton()
        btn.setTitle("确定", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = ThemeColor()
        btn.addTarget(self, action: #selector(clickComforeBtn), for: UIControlEvents.touchUpInside)
        bottomView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
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
    
    func initRangSilderView(){
        let titleLabel = UILabel()
        titleLabel.text = "价格"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(140)
        }
        
        let rangSlider = RangeSeekSlider()
        rangSlider.minValue = 0
        rangSlider.maxValue = 2000
        rangSlider.selectedMaxValue = maxPrice == nil ? 2000 : CGFloat(Double(maxPrice!)!)
        rangSlider.selectedMinValue = minPrice == nil ? 0 : CGFloat(Double(minPrice!)!)
        rangSlider.lineHeight = 5
        rangSlider.tintColor = LWColor(r: 240, g: 242, b: 245, a: 1.0)
        rangSlider.minLabelColor = UIColor.black
        rangSlider.maxLabelColor = UIColor.black
        rangSlider.handleColor = ThemeColor()
        rangSlider.colorBetweenHandles = ThemeColor()
        rangSlider.delegate = self
        bottomView.addSubview(rangSlider)
        rangSlider.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint =  touch.location(in: self.view)
        return !bottomView.frame.contains(touchPoint)
    }
    @objc func tapView(_ sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    @objc func clickComforeBtn(){
        if self.sendValueCallBack != nil {
            self.sendValueCallBack!(self.starLevel,self.minPrice,self.maxPrice)
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SelectPriceViewController:UICollectionViewDelegate,UICollectionViewDataSource,RangeSeekSliderDelegate{
    
    
    //MARK:UICollectionViewDelegate
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SelectPriceHeaderView
        header.clickCloseBtnCalllBack = {[weak self] in
            if self?.sendValueCallBack != nil {
                self?.sendValueCallBack!(self?.starLevel,self?.minPrice,self?.maxPrice)
            }
            self?.dismiss(animated: true, completion: nil)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell = indexPath.row
        if indexPath.row > 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! SearchCell
            starLevel = cell.titlelabel.text
        }else{
            starLevel = nil
        }
        collectionView.reloadData()
    }
    
    //MARK:RangeSeekSliderDelegate
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat){
        if maxValue < 2000 {
            maxPrice = "\(Int(maxValue))"
        }else{
            maxPrice = nil
        }
        
        if minValue == 0 {
            minPrice = nil
        }else{
            minPrice = "\(Int(minValue))"
        }
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        if maxPrice == nil {
            return "2000+"
        }
        return "\(Int(maxValue))"
    }
}




