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

class MainViewController: UIViewController,FSPagerViewDelegate,FSPagerViewDataSource {
  
    @IBOutlet weak var newsView: FSPagerView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        newsViewInit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func newsViewInit(){
        newsView.delegate = self
        newsView.dataSource = self
        newsView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        newsView.automaticSlidingInterval = 4
        newsView.interitemSpacing = 8.0
        newsView.isInfinite = true
        newsView.transformer = FSPagerViewTransformer(type: FSPagerViewTransformerType.overlap)
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return fakeUrlArray().count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.loadImageUsingCacheWithUrlString(urlString: fakeUrlArray()[index])
        cell.imageView?.contentMode = .scaleAspectFit
        
        // Add a gesture recognizer the first time
        if cell.imageView?.gestureRecognizers?.count != 1 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            cell.imageView?.isUserInteractionEnabled = true
            cell.imageView?.addGestureRecognizer(tap)
        }
        return cell
    }
    
    func fakeUrlArray() -> [String]{
        let imagesArray:[String] = ["https://api.twdd.com.tw/upload/rotateimage/gUOg6U6wbbz5RwudWx3Erntze9zDbMVpYxNIKARh.png","https://api.twdd.com.tw/upload/rotateimage/uUyh0TjPEFk01ptLzLv3Qhgo2NkCK9hqARsft6jW.jpeg","https://api.twdd.com.tw/upload/rotateimage/n6pRdvoQwkdiq2Q46RNcPCCWlzSQGGVCdjFwU788.png"]
        return imagesArray
    }
    
    @objc func imageTapped(){
        print("123123")
    }

}

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {

        self.image = nil
        print("here the URL of the image", urlString)
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = cachedImage as? UIImage
            return
        }
        // otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}
