//
//  News.swift
//  Mock
//
//  Created by DungHM on 25/11/24.
//

import UIKit
import Foundation
typealias Completion = (Bool, String) -> Void

final class Article {
    var title: String?
    var author: String?
    var source: String?
    var thumbnalURL: String?
    var thumbnailImg: UIImage?
    
    
    init(json: JSON) {
        
        self.title = json["title"] as? String ?? ""
        self.author = json["author"] as? String ?? ""
        let sourceDictionary = json["source"] as! [String : Any]
        source = sourceDictionary["name"] as? String ?? ""
        self.thumbnalURL = json["urlToImage"] as? String ?? ""
    }
}
