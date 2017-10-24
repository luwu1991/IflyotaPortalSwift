//
//  HomepageViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/18.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import Kingfisher
class HomepageViewController: LWBaseViewController{
    
    let mainScrollView = UIScrollView()
    var scrollView:UIScrollView?
    let newsView = UIScrollView()
    var banners:[String]? = [String]()
    var news:[String]=[String]()
    var scenicSpots:[ScenicSpotModel]=[ScenicSpotModel]()
    var currentPage = 1
    var cycyleTimer : Timer?
    var scenicSpotView:ScenicSpotView?
    let bannelViewHeight:CGFloat = 210
    let clessicViewHeight:CGFloat = 155
    let newsViewHeight:CGFloat = 36
    let otherAppViewHeight:CGFloat = 40
    let scenicSpotViewHeight:CGFloat = 170
    let items = [["ResourceUrl":"list-item1","title":"酒店"],["ResourceUrl":"list-item2","title":"景点"],["ResourceUrl":"list-item3","title":"线路"],
                 ["ResourceUrl":"list-item1","title":"自由行"],["ResourceUrl":"list-item2","title":"土特产"],["ResourceUrl":"list-item3","title":" "]]
    let otherApps = [["ResourceUrl":"aitugzh-icon","title":"微信公众号"],["ResourceUrl":"fyzs-icon","title":"语音翻译"],["ResourceUrl":"linxi-icon","title":"灵犀助手"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        mainScrollView.frame = CGRect (x: 0, y: -20, width: SCREENW, height: SCREENH)
        mainScrollView.backgroundColor = garyColor
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.showsHorizontalScrollIndicator = false
        view.addSubview(mainScrollView)
        
        LWNetworkTool.shareNetworkTool.loadHomePageBanner { (items) in
            for item in items{
                    self.banners?.append(item.resourceUrl)
            }
            self.banners?.append(items.first!.resourceUrl!)
            self.banners?.insert(items.last!.resourceUrl!, at: 0)
            self.initBannelView()
            self.addCycleTimer()
            
        }
        
        LWNetworkTool.shareNetworkTool.loadHomePageNews {(items) in
            for item in items{
                self.news.append(item.title)
            }
            
            self.loadNews()
        }
        
        LWNetworkTool.shareNetworkTool.loadScenicSpot { (items) in
            self.scenicSpots = items
            self.initScenicSpotView()
        }
        
        
        LWNetworkTool.shareNetworkTool.loadHomePageTags { (items) in
            self.initTagsView(items)
        }
        
        initClessicView()
        initOtherAppView()
        
        
    }
    
    
    fileprivate func addCycleTimer() {
        cycyleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycyleTimer!, forMode:RunLoopMode.commonModes)
    }
    
    //MARK:initSubView
    fileprivate func initBannelView() {
        scrollView = UIScrollView()
        scrollView?.frame = CGRect(x: 0, y: 0, width: SCREENW, height: bannelViewHeight)
        scrollView?.backgroundColor = UIColor.white
        scrollView?.contentSize = CGSize (width: 3*SCREENW, height: bannelViewHeight)
        scrollView?.contentOffset = CGPoint (x: SCREENW, y: 0)
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
        mainScrollView.addSubview(scrollView!)
        for index in 0...2 {
            let imageView = UIImageView()
            imageView.frame = CGRect (x: CGFloat(index)*SCREENW, y: 0, width: SCREENW, height: bannelViewHeight)
            imageView.tag = index+1
            
            imageView.kf.setImage(with: URL (string: self.banners![index]))
            
            scrollView?.addSubview(imageView)
        }
    }
    
    func initClessicView() {
        let clessicView = UIView()
        clessicView.frame = CGRect (x: 0, y: bannelViewHeight, width: SCREENW, height: clessicViewHeight)
        clessicView.backgroundColor = UIColor.white
        mainScrollView.addSubview(clessicView)
        
        for index in 0...5 {
            let item = items[index]
            let row = Int(index / 3)+1
            let column = index % 3
            let button = UIButton()
            let buttonHeight:CGFloat = 65
            let buttonWidth:CGFloat = 55
            let leftDistance = (SCREENW - 3*buttonWidth - 2*80)/2
            let topDistance = (155 - buttonHeight*2)/3
            button.frame = CGRect (x: CGFloat(leftDistance)+CGFloat(CGFloat(column)*(buttonWidth+80)), y: CGFloat(topDistance*CGFloat(row)+buttonHeight*CGFloat(row - 1)), width: CGFloat(buttonWidth), height: buttonHeight)
            button.setTitle(item["title"], for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.titleLabel?.sizeToFit()
            button.setImage(Image(named: item["ResourceUrl"]!), for: UIControlState.normal)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 30, 10)
            button.titleEdgeInsets = UIEdgeInsetsMake(button.currentImage!.size.height/2+10,-button.currentImage!.size.width, 0, 0)
            button.addTarget(self, action: #selector(clickClessicBtn), for: UIControlEvents.touchUpInside)
            button.tag = index
            clessicView.addSubview(button)
        }
        
    }
    
    
    func initNewsView(){
        newsView.frame = CGRect (x: 0, y: bannelViewHeight+clessicViewHeight, width: SCREENW - 44, height: newsViewHeight)
        newsView.contentSize = CGSize (width: SCREENW - 44, height: CGFloat(news.count*26))
        newsView.showsVerticalScrollIndicator = false
        newsView.showsHorizontalScrollIndicator = false
        newsView.backgroundColor = UIColor.white
        newsView.isPagingEnabled = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        let more = UIButton()
        more.frame = CGRect (x: SCREENW - 44, y: 210+155, width: 44, height: 36)
        more.backgroundColor = UIColor.white
        more.setTitle("更多", for: UIControlState.normal)
        more.setTitleColor(LWColor(r: 0, g: 0, b: 0, a: 1.0), for: UIControlState.normal)
        more.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        more.titleLabel?.sizeToFit()
        more.addTarget(self, action: #selector(getMoreNews), for:UIControlEvents.touchUpInside)
        mainScrollView.addSubview(more)
        mainScrollView.addSubview(newsView)
    }
    
    
    func initOtherAppView() {
        let otherAppView = UIView()
        otherAppView.frame = CGRect (x: 0, y: bannelViewHeight+clessicViewHeight+newsViewHeight+1, width: SCREENH, height: otherAppViewHeight)
        otherAppView.backgroundColor = UIColor.white
        mainScrollView.addSubview(otherAppView)
        
        for index in 0...otherApps.count-1 {
            let btn = UIButton()
            let item = otherApps[index]
            btn.frame = CGRect (x: CGFloat(index)*SCREENW/3, y: 12, width: SCREENW/3, height: 16)
            btn.setImage(UIImage (named: item["ResourceUrl"]!), for: UIControlState.normal)
            btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            btn.setTitle(item["title"]!, for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.titleLabel?.sizeToFit()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            btn.addTarget(self, action: #selector(gotoOtherApp), for: UIControlEvents.touchUpInside)
            otherAppView.addSubview(btn)
        }
        
    }

    func initScenicSpotView() {
        scenicSpotView = ScenicSpotView.init(frame: CGRect (x: 0, y: bannelViewHeight+clessicViewHeight+newsViewHeight+otherAppViewHeight+1+8, width: SCREENW, height: scenicSpotViewHeight),data:self.scenicSpots)
        mainScrollView.addSubview(scenicSpotView!)
    }
    
    func initTagsView(_ tags:[TagModel]) {
        let tagsView = LWSwiperView.init(frame: CGRect(x: 0, y: bannelViewHeight+clessicViewHeight+newsViewHeight+otherAppViewHeight+scenicSpotViewHeight+1+8+10, width: SCREENW, height: 1000+40), tags: tags)
        tagsView.scrollView.height = 1000 + 44
        mainScrollView.addSubview(tagsView)
        mainScrollView.contentSize = CGSize (width: SCREENW, height: tagsView.y+tagsView.height + 44 )
        
        for index in 0...tags.count - 1{
            let tag = tags[index].tName
            let VC = HomePageTagViewController()
            VC.tag = tag
            VC.view.frame = CGRect(x: CGFloat(index)*SCREENW, y: 0, width: SCREENW, height: SCREENH-40 - 20 - 44)
            VC.mainScrollView = mainScrollView
            addChildViewController(VC)
            tagsView.scrollView.addSubview(VC.view)
        }
    }
    

    func loadImage(){
        let index = scrollView!.contentOffset.x / SCREENW
        let imageViewLeft = scrollView!.viewWithTag(1) as! UIImageView
        let imageViewMiddle = scrollView!.viewWithTag(2) as! UIImageView
        let imageViewRight = scrollView!.viewWithTag(3) as! UIImageView
        if index == 0 {
            imageViewLeft.kf.setImage(with: currentPage == 0 ? URL(string: banners![banners!.count - 2]):URL(string:banners![currentPage]))
            imageViewRight.kf.setImage(with: currentPage == 0 ? URL(string: banners![1]):URL(string:banners![currentPage]))
            imageViewMiddle.kf.setImage(with: currentPage == 0 ? URL(string:banners![banners!.count - 1]):URL(string:banners![currentPage-1]))
            currentPage == 0 ? (currentPage = banners!.count-1) : (currentPage = currentPage - 1)
        }
        
        if index == 2 {
            imageViewLeft.kf.setImage(with: currentPage == banners!.count - 1 ? URL(string: banners![currentPage - 1]):URL(string:banners![1]))
            imageViewRight.kf.setImage(with: currentPage == banners!.count - 1 ? URL(string: banners![1]):URL(string:banners![currentPage]))
            imageViewMiddle.kf.setImage(with: currentPage == banners!.count - 1 ? URL(string:banners![0]):URL(string:banners![currentPage+1]))
            currentPage == banners!.count-1 ? (currentPage = 0) : (currentPage = currentPage + 1)
        }
    }
    
    func loadNews(){
        var newViews = [UIView]()
        for index in 0...news.count - 1{
            let newView = Bundle.main.loadNibNamed("NewView", owner: nil, options: nil)?.first as! NewView
            newView.frame = CGRect (x: 0, y: 0, width: Int(SCREENW) - 44, height: 36)
            newView.titleBtn.setTitle(news[index], for: UIControlState.normal)
            newView.tag = index + 1
            newViews.append(newView)
        }
        let more = UIButton()
        more.frame = CGRect (x: SCREENW - 44, y: 210+155, width: 44, height: 36)
        more.backgroundColor = UIColor.white
        more.setTitle("更多", for: UIControlState.normal)
        more.setTitleColor(LWColor(r: 0, g: 0, b: 0, a: 1.0), for: UIControlState.normal)
        more.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        more.titleLabel?.sizeToFit()
        more.addTarget(self, action: #selector(getMoreNews), for:UIControlEvents.touchUpInside)
        mainScrollView.addSubview(more)
        
        let newCycyleView = LWCycyleView.init(frame: CGRect (x: 0, y: 210+155, width: SCREENW - 44, height: 36), subcycyleViews: newViews, cycyleTime: 2.0, type: .bottom)
        mainScrollView.addSubview(newCycyleView)
    }
    
    
    //MARK:antion
    @objc fileprivate func scrollToNext() {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.scrollView?.contentOffset = CGPoint (x: 2*SCREENW, y: 0)
        }) { (success) in
            self.loadImage()
            self.scrollView?.contentOffset = CGPoint (x: SCREENW, y: 0)
        }
    }
    
    @objc func clickClessicBtn(sender:UIButton){
        var VC:UIViewController
        switch sender.tag {
        case 0:
            VC = HotelViewController()
        default:
            VC = UIViewController()
            break
        }
        
        VC.hidesBottomBarWhenPushed = true
        VC.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func getMoreNews() {
        
    }
    
    @objc func gotoOtherApp(sender:UIButton){
        
    }
    
}

extension HomepageViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImage()
        
        scrollView.contentOffset = CGPoint (x: SCREENW, y: 0)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cycyleTimer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}
