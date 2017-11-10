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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = classicModel!.name
        initMainscrollView()
        initTopView()
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
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNeedsNavigationBackground(alpha:1.0)
       
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
        mainScrollView.contentSize = CGSize.init(width: SCREENW, height: SCREENH + SCREENW*540/755 - 64)
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
        topImageView.kf.setImage(with: URL.init(string: classicModel!.resourceUrl))
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(SCREENW)
            make.height.equalTo(SCREENW*540/755)
        }
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

extension LocalProductListViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxAlphaOffset:CGFloat = SCREENW*540/755 - 64 - 45;
        let offset:CGFloat = scrollView.contentOffset.y;
        let height = SCREENW*540/755 - 64
        let topImageView = view.viewWithTag(1) as! UIImageView
        if  offset > 0 && SCREENW*540/755 - offset >= 64 {
            print(Date())
            print(SCREENW*540/755 - offset)
            topImageView.snp.updateConstraints({ (make) in
             
                make.height.equalTo(SCREENW*540/755 - offset)
            })
            topImageView.layoutIfNeeded()
        }else{
            
        }
//        self.navigationController?.setNeedsNavigationBackground(alpha:alpha)
        
    }
}
