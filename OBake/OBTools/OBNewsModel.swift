//
//  OBNewsModel.swift
//  OBake
//
//  Created by Otis on 2019/4/26.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation

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
