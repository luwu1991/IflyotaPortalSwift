//
//  SearchHotelListViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/30.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit

class SearchHotelListViewController: LWBaseViewController {
    let searchView = Bundle.main.loadNibNamed("HotelScearchView", owner: nil, options: nil)?.first as! HotelSearchView
    var startDate:Date?
    var endDate:Date?
    var keyword:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchView()
        initFilterView()
        // Do any additional setup after loading the view.
    }
    
    func initSearchView() {
        
        searchView.frame = CGRect (x: 0, y: 0, width: SCREENW - 100, height: 30)
        let formate = DateFormatter()
        formate.dateFormat = "MM-dd"
        searchView.startDate.text = "住 " + formate.string(from: startDate!)
        searchView.endDate.text = "离 " + formate.string(from: endDate!)
        if keyword != nil {
            searchView.keyword.text = keyword
        }
        searchView.clickDate = {[weak self] in
            let calenVC = CalendarViewController()
            calenVC.dateCallBack = {(startDate,endDate) in
                self?.startDate = startDate
                self?.endDate = endDate
                self?.setDateText()
            }
            calenVC.startDate = self?.startDate
            calenVC.endDate = self?.endDate
            self?.navigationController?.pushViewController(calenVC, animated: true)
        }
        
        searchView.clickKeyword = { [weak self] in
            let searchVC = SearchHotelViewController()
            searchVC.searchTitleCallBack = {(searchTitle) in
                self?.keyword = searchTitle
                self?.searchView.keyword.text = searchTitle
            }
            self?.navigationController?.pushViewController(searchVC, animated: true)
        }
        self.navigationItem.titleView = searchView
    }
    
    func initFilterView(){
        let btnW = (SCREENW - 20 - 2)/2
        let leftBtn = UIButton()
        leftBtn.backgroundColor = UIColor.white
        leftBtn.setImage(UIImage (named: "filter_icon"), for: UIControlState.normal)
        leftBtn.setTitle("筛选", for: UIControlState.normal)
        leftBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        let path = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: btnW, height: 40), byRoundingCorners: [.topLeft,.bottomLeft], cornerRadii: CGSize(width: 4, height:4))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = CGRect (x: 0, y: 0, width: btnW, height: 40)
        maskLayer1.path = path.cgPath
        leftBtn.layer.mask = maskLayer1
        view.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(69)
            make.width.equalTo(btnW)
            make.height.equalTo(40)
        }
        
        let rightBtn = UIButton()
        rightBtn.backgroundColor = UIColor.white
        rightBtn.setImage(UIImage (named: "rank_icon"), for: UIControlState.normal)
        rightBtn.setTitle("排序", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5)
        let path2 = UIBezierPath(roundedRect:CGRect (x: 0, y: 0, width: btnW, height: 40), byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: 4, height:4))
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = CGRect (x: 0, y: 0, width: btnW, height: 40)
        maskLayer2.path = path2.cgPath
        rightBtn.layer.mask = maskLayer2
        view.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(69)
            make.width.equalTo(btnW)
            make.height.equalTo(40)
        }
    }
    
    func setDateText(){
        let formate = DateFormatter()
        formate.dateFormat = "MM-dd"
        searchView.startDate.text = "住 " + formate.string(from: startDate!)
        searchView.endDate.text = "离 " + formate.string(from: endDate!)
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
