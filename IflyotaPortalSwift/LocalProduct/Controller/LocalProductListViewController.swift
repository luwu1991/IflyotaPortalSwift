//
//  LocalProductListViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/10.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LocalProductListViewController: LWBaseViewController {
    let mainScrollView = UIScrollView()
    var classicModel:LocalProductClassic?
    var collectionView:UICollectionView?
    var dataSource = [LocalProduct]()
    let menuView = UIView()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = classicModel!.name
        initTopView()
        initMenuView()
        initListView()
        
        netWorking()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let topImageView = view.viewWithTag(1) as! UIImageView
        view.bringSubview(toFront: topImageView)
        view.bringSubview(toFront: menuView)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.titleView?.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setNeedsNavigationBackground(alpha:0.0)
        self.navigationItem.titleView?.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    func netWorking(){
        LWNetworkTool.shareNetworkTool.loadLocalProductList(page: 1, rows: 10, sort: "SRecommendedOrder", order: "desc", IID: classicModel!.iID!, keyWord: "", minPrice: "", maxPrice: "") { (items) in
            self.dataSource = items
            self.collectionView?.reloadData()
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
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH + SCREENW*360/750 + 300)
        mainScrollView.delegate = self
   
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH)
        }
    }
    
    func initListView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (SCREENW - 23)/2, height: 24/35*(SCREENW - 23))
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 9, 5, 9)
        collectionView = UICollectionView (frame: CGRect (x: 0, y: 64, width: SCREENW, height:SCREENH), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = garyColor
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.contentInset = UIEdgeInsetsMake(SCREENW*360/750 - 64 + 49,0, 0,0)
        collectionView?.register(UINib.init(nibName: "LocalProductCell", bundle: nil), forCellWithReuseIdentifier: "LocalProductCell")
      
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (make) in
            make.top.equalTo(64)
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH-64)
        })
    }
    
    func initTopView(){
        let topImageView = UIImageView()
        topImageView.tag = 1
        topImageView.kf.setImage(with: URL.init(string: classicModel!.resourceUrl))
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENW*360/750)
        }
    }
    
    func initMenuView(){
        menuView.backgroundColor = UIColor.white
        view.addSubview(menuView)
        let topImageView = view.viewWithTag(1) as! UIImageView
        menuView.snp.makeConstraints { (make) in
            make.left.equalTo(9)
            make.right.equalTo(-9)
            make.height.equalTo(44)
            make.top.equalTo(topImageView.snp.bottom).offset(5)
        }
    }
    
    @objc func refreshData(){
        menuView.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocalProductListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalProductCell", for: indexPath) as! LocalProductCell
        let model = dataSource[indexPath.row]
        cell.imageView.kf.setImage(with: URL.init(string: model.imgUrl))
        cell.titleLabel.text = model.subHead
        cell.priceLabel.text = "￥\(model.minPrice!)"
        return cell
    }
}


extension LocalProductListViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset:CGFloat = scrollView.contentOffset.y;
        let topImageView = view.viewWithTag(1) as! UIImageView
        if  offset > -SCREENW*360/750 + 64 - 49 && offset <= -49  {
            print(64 - offset - 49)
            topImageView.snp.updateConstraints({ (make) in
             
                make.height.equalTo(64 - offset - 49)
            })
            topImageView.layoutIfNeeded()
        }else if  offset > -49{
            topImageView.snp.updateConstraints({ (make) in
                
                make.height.equalTo(64)
            })
            topImageView.layoutIfNeeded()
        }
        
        if offset < -SCREENW*360/750 + 64 - 49 {
            topImageView.snp.updateConstraints({ (make) in
                
                make.height.equalTo(SCREENW*360/750)
            })
            topImageView.layoutIfNeeded()
        }
       
    }
}
