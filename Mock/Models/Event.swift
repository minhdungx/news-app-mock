//
//  Event.swift
//  Mock
//
//  Created by DungHM on 26/11/24.
//

import UIKit
import Foundation
typealias Completion = (Bool, String) -> Void


final class Event {
    var title: String?
    var description: String?
    var date: Date?
    var thumbnailURL: String?
    var thumbnailImg: UIImage?
    var author: String?
    var source: String?
    
    
    init(json: JSON) {
        self.title = json["title"] as? String ?? ""
        self.description = json["description"] as? String ?? ""
        self.thumbnailURL = json["urlToImage"] as? String ?? ""
        let dateString = json["publishedAt"] as? String ?? ""
        self.author = json["author"] as? String ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.date = dateFormatter.date(from: dateString) ?? Date()
        let sourceDictionary = json["source"] as! [String : Any]
        source = sourceDictionary["name"] as? String ?? ""

    }
}

