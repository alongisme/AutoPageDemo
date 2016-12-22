//
//  AutoPageView.swift
//  AutoPageDemo
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 along. All rights reserved.
//

import Foundation
import UIKit

class AutoPageView : UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    let PageItemIdentifier = "PageItemIdentifier"
    let BaseValue:Int = 500 //数组基数
    var pageCollection:UICollectionView?
    var timer:Timer!
    var imageArray:[String] = []
    var pageControl:UIPageControl?
    
    func loadImage(_ list:[String]) {
        
        if list.count > 0 {
            if imageArray.count > 0 {
                imageArray.removeAll()
            }
            for _ in 1...BaseValue {
                imageArray += list
            }
            
            initWithSubview()
        }
    }
    
    func initWithSubview() {
        
        if pageCollection != nil {
            reloadPageData()
            return
        }
        
        let pageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        pageCollectionViewFlowLayout.itemSize = self.bounds.size
        pageCollectionViewFlowLayout.minimumLineSpacing = 0
        pageCollectionViewFlowLayout.minimumInteritemSpacing = 0
        pageCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        pageCollection = UICollectionView(frame: self.bounds, collectionViewLayout: pageCollectionViewFlowLayout)
        pageCollection?.backgroundColor = UIColor.clear
        pageCollection?.delegate = self
        pageCollection?.dataSource = self
        pageCollection?.showsVerticalScrollIndicator = false
        pageCollection?.showsHorizontalScrollIndicator = false
        pageCollection?.isPagingEnabled = true
        self.addSubview(pageCollection!)
        
        pageCollection?.register(pageCollectionViewCell.self, forCellWithReuseIdentifier: PageItemIdentifier)
        pageCollection?.selectItem(at: IndexPath.init(row: imageArray.count / BaseValue * 2, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        pageControl = UIPageControl()
        pageControl?.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: (pageCollection?.bounds.size.width)!, height: 25))
        pageControl?.center = CGPoint.init(x: (pageCollection?.center.x)!, y: (pageCollection?.bounds.size.height)! - 25 - 10)
        pageControl?.numberOfPages = imageArray.count / BaseValue;
        pageControl?.hidesForSinglePage = true
        pageControl?.pageIndicatorTintColor = UIColor.black
        pageControl?.currentPageIndicatorTintColor = UIColor.white
        self.addSubview(pageControl!)
        
        startTimerWithSlide()
    }
    
    func reloadPageData() {
        pageCollection?.reloadData()
        pageControl?.currentPage = 0
        pageControl?.numberOfPages = imageArray.count / BaseValue
        pageCollection?.selectItem(at: IndexPath.init(row: imageArray.count / BaseValue * 2, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        startTimerWithSlide()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageItemIdentifier, for: indexPath) as! pageCollectionViewCell
        cell.loadItemImage(name: imageArray[indexPath.row])
        return cell
    }
    
    func startTimerWithSlide() {
        
        if timer != nil {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(AutoPageView.slideAction), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
    }
    
    func slideAction() {
        pageCollection?.setContentOffset(CGPoint.init(x: (pageCollection?.contentOffset.x)! + self.bounds.size.width, y: 0), animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadPageIndex(scrollView)
        startTimerWithSlide()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadPageIndex(scrollView)
    }
    
    func reloadPageIndex(_ scrollView: UIScrollView) {
        
        let currentIndex = (Int(scrollView.contentOffset.x / self.bounds.size.width) % (imageArray.count / BaseValue))
        
        if currentIndex >= 0 {
            pageControl?.currentPage = currentIndex
        }
        
        if Int(scrollView.contentOffset.x / self.bounds.size.width) == 0 {
            pageCollection?.selectItem(at: IndexPath.init(row: imageArray.count / BaseValue * 2, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }else if Int(scrollView.contentOffset.x / self.bounds.size.width) >= imageArray.count - 1 {
            pageCollection?.selectItem(at: IndexPath.init(row: imageArray.count / BaseValue * 2 + 3, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
}
