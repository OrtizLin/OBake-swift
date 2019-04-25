//
//  OBNewsView.swift
//  OBake
//
//  Created by Otis on 2019/4/25.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import FSPagerView

class News {
    var title: String?
    var imageUrl: String?
    var url: String?
    
    init(title: String, imageUrl: String, url: String){
        self.title = title
        self.imageUrl = imageUrl
        self.url = url
    }
}

protocol NewsManageable {
    func initView(view: FSPagerView)
    func getFakeDataArray() -> [News]
}

class NewsManager: NewsManageable {
  
    static let shared = NewsManager()
    
    func initView(view: FSPagerView) {
        view.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        view.automaticSlidingInterval = 4
        view.interitemSpacing = 8.0
        view.isInfinite = true
        view.transformer = FSPagerViewTransformer(type: FSPagerViewTransformerType.overlap)
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
