//
//  LocalProductViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/11/10.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class LocalProductViewController:LWBaseViewController {
    
    let mainScrollView = UIScrollView()
    var classicDataSource = [LocalProductClassic]()
    var hotDataSource = [LocalProduct]()
    var classicView:LocalProductHotView?
    var collectionView:UICollectionView?
    var headerView  = UICollectionReusableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "土特产"

        initMainscrollView()
        initClassicView()
        initListView()
        netWorking()
    }

    override func viewDidLayoutSubviews() {
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: collectionView!.y + collectionView!.height + 64)
    }
    
    func netWorking(){
        LWNetworkTool.shareNetworkTool.loadHomePageBanner(pageName:"土特产",moduleName: "顶部") { (items) in
            var datas = [HomePageBannel]()
            if items.count == 1{
                datas.append(items.first!)
                datas.append(items.last!)
                datas.append(items.first!)
            }
            self.initBanelView(datas: datas)
        }
        
        LWNetworkTool.shareNetworkTool.loadSpecialtyLocalProduct(page: 1, rows: 8, sort: "SISort", order: "desc") { (items) in
            self.hotDataSource = items
            self.classicView?.reloadDate(self.hotDataSource)
        }
        
        LWNetworkTool.shareNetworkTool.loadLocalproductClassic { (items) in
            self.classicDataSource = items
            self.updateListView()
        }
    }
    
    func initMainscrollView(){
        mainScrollView.backgroundColor = view.backgroundColor
        mainScrollView.frame = CGRect.init(x: 0, y:0, width: SCREENW, height: SCREENH)
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        mainScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH+184)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENH)
        }
    }
    
    func initBanelView(datas:[HomePageBannel]){
        var banelViews = [UIImageView]()
        for index in 0...datas.count - 1{
            let imageView = UIImageView()
            let model = datas[index]
            imageView.frame = CGRect(x: index*Int(SCREENW), y: 0, width: Int(SCREENW), height: 120)
            imageView.kf.setImage(with: URL(string: model.resourceUrl))
            banelViews.append(imageView)
        }
        
        let banelView = LWCycyleView.init(frame: CGRect (x: 0, y: 0, width: SCREENW, height: 120), subcycyleViews: banelViews, cycyleTime: 2.0, type: .right)
        mainScrollView.addSubview(banelView)
        banelView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(SCREENW/755*240)
            make.width.equalTo(SCREENW)
        }
    }
    
    func initClassicView(){
        classicView = LocalProductHotView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), data: self.hotDataSource)
        mainScrollView.addSubview(classicView!)
        classicView!.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(SCREENW/755*240 + 10)
            make.width.equalTo(SCREENW)
            make.height.equalTo(170)
        })
    }
    
    func initListView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: SCREENW - 20, height: 75)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flowLayout.headerReferenceSize = CGSize.init(width: SCREENW, height: 70)
        collectionView = UICollectionView (frame: CGRect (x: 0, y: 40, width:SCREENW, height: 0), collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isScrollEnabled = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UINib.init(nibName: "LocalProductClassicCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        mainScrollView.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalTo(classicView!.snp.bottom).offset(10)
            make.width.equalTo(SCREENW)
            make.height.equalTo(70)
        })
        

    }
    
    func initHeaderView(){
        let tagImg = UIImageView()
        tagImg.image = UIImage.init(named: "title-bg")
        headerView.addSubview(tagImg)
        tagImg.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(10)
        }
        
        let tagTitle = UILabel()
        tagTitle.font = UIFont.systemFont(ofSize: 14)
        tagTitle.text = "特产分类"
        tagTitle.textAlignment = .center
        tagTitle.backgroundColor = UIColor.yellow
        tagTitle.sizeToFit()
        headerView.addSubview(tagTitle)
        tagTitle.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
        }
    }
    
    
    func updateListView(){
        collectionView?.snp.updateConstraints({ (make) in
            make.height.equalTo(70+85*self.classicDataSource.count)
        })
        collectionView?.layoutIfNeeded()
        collectionView?.reloadData()
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

extension LocalProductViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classicDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LocalProductClassicCell
        let model = classicDataSource[indexPath.row]
        cell.titleLabel.text = model.name
        cell.numLabel.text = String(model.productNum)
        cell.backImage.kf.setImage(with: URL.init(string: model.resourceUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        if header != self.headerView {
            self.headerView = header
            self.initHeaderView()
        }
        
        return self.headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = classicDataSource[indexPath.row]
        let vc = LocalProductListViewController()
        vc.classicModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LocalProductViewController:UIScrollViewDelegate{
    
}
