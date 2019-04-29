//
//  OBNewsView.swift
//  OBake
//
//  Created by Otis on 2019/4/25.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import FSPagerView
import UIKit

protocol NewsManageable {
    func initView(view: FSPagerView)
    func getFakeDataArray() -> [News]
}

class NewsManager: UIViewController, NewsManageable  {
  
    static let shared = NewsManager()
    
    func initView(view: FSPagerView) {
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        view.automaticSlidingInterval = 4
        view.interitemSpacing = 8.0
        view.isInfinite = true
        view.transformer = FSPagerViewTransformer(type: FSPagerViewTransformerType.overlap)
        view.delegate = self
        view.dataSource = self

    }
    
    func getFakeDataArray() -> [News] {
        let dataOne = News(title: "First News", imageUrl: "https://api.twdd.com.tw/upload/rotateimage/WMEaQTzPqrFmYSTJZ5YS1nLBZiC9xE64N87MtbeQ.png", url: "http://bit.ly/2EnmmsL")
        let dataSecond = News(title: "Second News", imageUrl: "https://api.twdd.com.tw/upload/rotateimage/o5aqsXgmcu1lY6Pk8Ie8bAYTLaL596L0vgTz87xi.png", url: "http://bit.ly/2NmMg3K")
        let dataThird = News(title: "Third News", imageUrl: "https://api.twdd.com.tw/upload/rotateimage/1gkeDt9ei4azXQR4nfmkxmgIyrkCQ64H3mtStjvU.jpeg", url: "https://news.twdd.tw/news/discount/229-20181107")
        
        var dataArray = [News]()
        dataArray.append(dataOne)
        dataArray.append(dataSecond)
        dataArray.append(dataThird)
    
        return dataArray
    }
    
}

extension NewsManager: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return NewsManager.shared.getFakeDataArray().count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadImageUsingCacheWithUrlString(urlString: NewsManager.shared.getFakeDataArray()[index].imageUrl!)
        cell.imageView?.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNewsGesture(_:)))
        cell.imageView?.isUserInteractionEnabled = true
        cell.imageView?.addGestureRecognizer(tap)
        cell.imageView?.tag = index
        cell.selectedBackgroundView?.backgroundColor = .white
        cell.textLabel?.text = NewsManager.shared.getFakeDataArray()[index].title
        
        return cell
    }
    
    @objc func handleNewsGesture(_ gesture : UITapGestureRecognizer) {
                let view = gesture.view
                let tag = view?.tag
        
        guard let url = URL(string: NewsManager.shared.getFakeDataArray()[tag ?? 0].url ?? "https://www.yahoo.com.tw") else { return }
        UIApplication.shared.open(url)
        
    }
    
    
}
