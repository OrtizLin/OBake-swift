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
        let dataOne = News(title: "布丁狗的好吃戚風蛋糕", imageUrl: "https://i.imgur.com/UYyw6Mu.jpg", url: "https://www.surveycake.com/s/JzWL5")
        let dataSecond = News(title: "酷企鵝的香甜橙條", imageUrl: "https://i.imgur.com/BN2FJuY.jpg", url: "https://www.surveycake.com/s/JzWL5")
        let dataThird = News(title: "美樂蒂的難吃巧克力", imageUrl: "https://i.imgur.com/kFgx9OT.jpg", url: "https://www.surveycake.com/s/JzWL5")
        
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
