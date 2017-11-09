//
//  ScenicSpotDetailViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/8.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class ScenicSpotDetailViewController: LWBaseViewController {
    var iid:String?
    var model:ScenicSpotDetail?
    let topViewHeight = SCREENW*540/755 + 200
    let mainScrollView = UIScrollView()
    let topTitleView = UIView()
    let titleLabel = UILabel()
    let notesContentLabel = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:SCREENW, height: 70)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.isScrollEnabled = false
        view.register(UINib.init(nibName: "ScenicSpotDetailCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.mainScrollView.addSubview(view)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = model?.tName
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .black)
        titleLabel.sizeToFit()
        titleLabel.alpha = 0.0
        self.navigationItem.titleView = titleLabel
        initMainscrollView()
        initTopView()
        initListView()
        initBottomView()
        netWorking()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.titleView?.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setNeedsNavigationBackground(alpha:0.0)
        self.navigationItem.titleView?.isHidden = false
        self.navigationItem.titleView?.alpha = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNeedsNavigationBackground(alpha:1.0)
        self.navigationItem.titleView?.alpha = 1
    }
    
    
    override func viewDidLayoutSubviews() {
        let notesView = notesContentLabel.superview
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: notesView!.y + notesView!.height)
    }
    
    func netWorking(){
        LWNetworkTool.shareNetworkTool.loadScenicSpotDetailWith(self.iid!) { (item) in
            self.model = item
            self.updateView()
        }
    }
    
    
    func initMainscrollView(){
        mainScrollView.backgroundColor = view.backgroundColor
        mainScrollView.frame = CGRect.init(x: 0, y: -64, width: SCREENW, height: SCREENH + 64)
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        mainScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH)
        }
    }
    
    
    func initTopView(){
        let topImageView = UIImageView()
        topImageView.tag = 1
        mainScrollView.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENW*540/755)
        }
        
        
        topTitleView.backgroundColor = UIColor.white
        mainScrollView.addSubview(topTitleView)
        topTitleView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.top.equalTo(topImageView.snp.bottom)
            make.height.equalTo(205)
        }
        
        let titleLabel = UILabel()
        titleLabel.tag = 1
        
        titleLabel.sizeToFit()
        topTitleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(SCREENW-15)
            make.top.equalTo(30)
        }
        
        let characteristicLabel = UILabel()
        characteristicLabel.tag = 2
        characteristicLabel.font = UIFont.systemFont(ofSize: 14)
        characteristicLabel.sizeToFit()
        topTitleView.addSubview(characteristicLabel)
        characteristicLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREENW - 15)
        }
        
        
        let openTimeLabel = UILabel()
        openTimeLabel.tag = 3
        openTimeLabel.font = UIFont.systemFont(ofSize: 14)
        openTimeLabel.sizeToFit()
        topTitleView.addSubview(openTimeLabel)
        openTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(characteristicLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREENW - 15)
        }
        
        let themeLabel = UILabel()
        themeLabel.tag = 4
        themeLabel.font = UIFont.systemFont(ofSize: 14)
        themeLabel.sizeToFit()
        topTitleView.addSubview(themeLabel)
        themeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(openTimeLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREENW - 15)
        }
        
        let addressLabel = UILabel()
        addressLabel.tag = 5
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.sizeToFit()
        topTitleView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(themeLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREENW - 15)
        }
    }
    
    func initListView(){
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topTitleView.snp.bottom).offset(5)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(70)
        }
    }
    
    func initBottomView(){
        let detailView = UIView()
        detailView.backgroundColor = UIColor.white
        mainScrollView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom).offset(5)
            make.width.equalTo(SCREENW)
            make.height.equalTo(44)
            make.left.equalToSuperview()
        }
        let tagImgDetail = UIImageView()
        tagImgDetail.image = UIImage.init(named: "route-info-xc")
        detailView.addSubview(tagImgDetail)
        tagImgDetail.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(15)
        }
        
        let titleDetail = UILabel()
        titleDetail.font = UIFont.systemFont(ofSize: 14)
        titleDetail.text = "景点详情"
        titleDetail.sizeToFit()
        detailView.addSubview(titleDetail)
        titleDetail.snp.makeConstraints { (make) in
            make.left.equalTo(tagImgDetail.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        let checkLabel = UILabel()
        checkLabel.font = UIFont.systemFont(ofSize: 14)
        checkLabel.textColor = grayTitleColor
        checkLabel.text = "查看图文详情>"
        checkLabel.sizeToFit()
        detailView.addSubview(checkLabel)
        checkLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        
        let notesView = UIView()
        notesView.backgroundColor = UIColor.white
        mainScrollView.addSubview(notesView)
        notesView.snp.makeConstraints { (make) in
            make.top.equalTo(detailView.snp.bottom).offset(5)
            make.width.equalTo(SCREENW)
            make.left.equalToSuperview()
        }
        
        let notesImg = UIImageView()
        notesImg.image = UIImage.init(named:"route-info-ydxz")
        notesView.addSubview(notesImg)
        notesImg.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.size.equalTo(15)
        }
        
        let notesTitle = UILabel()
        notesTitle.font = UIFont.systemFont(ofSize: 14)
        notesTitle.text = "预订须知"
        notesTitle.sizeToFit()
        notesView.addSubview(notesTitle)
        notesTitle.snp.makeConstraints { (make) in
            make.left.equalTo(notesImg.snp.right).offset(5)
            make.top.equalTo(10)
        }
        
        notesContentLabel.numberOfLines = 0
        notesContentLabel.lineBreakMode = .byWordWrapping
        notesContentLabel.font = UIFont.systemFont(ofSize: 14)
        notesContentLabel.sizeToFit()
        notesView.addSubview(notesContentLabel)
        notesContentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(SCREENW - 30)
            make.top.equalTo(notesTitle.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateView(){
        self.titleLabel.text = model!.scenicName
        
        let topImageView = mainScrollView.viewWithTag(1) as! UIImageView
        topImageView.kf.setImage(with: URL.init(string: model!.imgUrl!))
        
        let titleLabel = topTitleView.viewWithTag(1) as! UILabel
        titleLabel.text = "\(model!.scenicName!)·\(model!.level!)级景区"
        let characteristicLabel = topTitleView.viewWithTag(2) as! UILabel
        characteristicLabel.attributedText = setSubLabelTextWith("景区特色  \(model!.characteristic!)")
        
        let openTimeLabel = topTitleView.viewWithTag(3) as! UILabel
        openTimeLabel.attributedText = setSubLabelTextWith("营业时间  \(model!.openTime!)")
        
        let themeLabel = topTitleView.viewWithTag(4) as! UILabel
        themeLabel.attributedText = setSubLabelTextWith("景点主题  \(model!.themes!)")
        
        let addressLabel = topTitleView.viewWithTag(5) as! UILabel
        addressLabel.attributedText = setSubLabelTextWith("景区地址  \(model!.address!)")
        
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(75*model!.productModelList[0].priceLists.count)
        }
        collectionView.reloadData()
        
        notesContentLabel.attributedText = stringFromHtml(string: model!.notes!)
        notesContentLabel.layoutIfNeeded()
        
    }
    
    func setSubLabelTextWith(_ title:String) -> NSMutableAttributedString{
        
        let range =  NSRange.init(location: 0, length: 4)
        let attributedText = NSMutableAttributedString(string: title)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,value:grayTitleColor, range: range)
       return attributedText
    }
    
    func stringFromHtml(string: String) -> NSAttributedString? {
        guard let data = string.data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScenicSpotDetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxAlphaOffset:CGFloat = SCREENW*540/755 - 64 - 45;
        let offset:CGFloat = scrollView.contentOffset.y;
        let alpha = offset / maxAlphaOffset;
        self.navigationController?.setNeedsNavigationBackground(alpha:alpha)
        titleLabel.alpha = alpha
    }
}

extension ScenicSpotDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model == nil {
            return 0
        }else{
            return model!.productModelList[0].priceLists.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScenicSpotDetailCell
        let model = self.model!.productModelList[0].priceLists[indexPath.row]
        cell.titleLabel.text = model.pLName
        cell.priceLabel.text = "￥\(model.pLPrice!)"
        return cell
        
    }
}

