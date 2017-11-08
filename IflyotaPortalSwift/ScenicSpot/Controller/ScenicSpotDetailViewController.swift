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
    let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = model?.tName
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .black)
        titleLabel.sizeToFit()
        titleLabel.alpha = 0.0
        self.navigationItem.titleView = titleLabel
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
    
    func netWorking(){
        LWNetworkTool.shareNetworkTool.loadScenicSpotDetailWith(self.iid!) { (item) in
            self.model = item
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
        
        let topTitleView = UIView()
        topTitleView.backgroundColor = UIColor.white
        mainScrollView.addSubview(topTitleView)
        topTitleView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.top.equalTo(topImageView.snp.bottom)
            make.height.equalTo(205)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "\(model!.tName)·\(model!.level)级景区"
        titleLabel.sizeToFit()
        topTitleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(SCREENW-15)
            make.top.equalTo(30)
        }
        
        let characteristicLabel = setSubLabelWith("景区特色  \(model!.characteristic)")
        topTitleView.addSubview(characteristicLabel)
        characteristicLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREENW - 15)
        }
        
    }
    
    
    func setSubLabelWith(_ title:String) -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        let range =  NSRange.init(location: 0, length: 4)
        let attributedText = NSMutableAttributedString(string: title)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor,value:grayTitleColor, range: range)
        label.attributedText = attributedText
        return label
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScenicSpotDetailViewController:UIScrollViewDelegate{
    
}
