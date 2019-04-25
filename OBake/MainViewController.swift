//
//  MainViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/21.
//  Copyright © 2019年 Otis. All rights reserved.
//

import UIKit
import Foundation
import FSPagerView
import SafariServices

class MainViewController: UIViewController,FSPagerViewDelegate,FSPagerViewDataSource {
  
    @IBOutlet weak var newsView: FSPagerView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        NewsManager.shared.initView(view:newsView)
        newsView.delegate = self
        newsView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return NewsManager.shared.getFakeUrlArray().count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadImageUsingCacheWithUrlString(urlString: NewsManager.shared.getFakeUrlArray()[index].imageUrl!)
        cell.imageView?.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleNewsGesture(_:)))
        cell.imageView?.isUserInteractionEnabled = true
        cell.imageView?.addGestureRecognizer(tap)
        cell.imageView?.tag = index

        return cell
    }
    
    @objc func handleNewsGesture(_ gesture : UITapGestureRecognizer) {
        let view = gesture.view
        let tag = view?.tag
        
        let safariViewController = SFSafariViewController(url:NSURL(string:  NewsManager.shared.getFakeUrlArray()[tag ?? 0].url ?? "https://www.yahoo.com.tw")! as URL)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true, completion: nil)
        
    }
}

extension MainViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


