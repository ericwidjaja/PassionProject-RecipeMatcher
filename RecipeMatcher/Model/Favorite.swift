//  Favorite.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/1/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation
import FirebaseFirestore

struct Favorite {
    let id: String?
    let imageUrl: String?
    let creatorID: String
    let dateCreated: Date?
    
    //create locally
    init(imageUrl: String? = nil, creatorID: String, dateCreated: Date? = nil) {
        self.imageUrl = imageUrl
        self.creatorID = creatorID
        self.dateCreated = dateCreated
        self.id = UUID().description
    }
    //create remotely
    init?(from dict: [String: Any], id: String) {
        guard let userID = dict["creatorID"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
            let imageUrl = dict["imageUrl"] as? String else { return nil}
        self.creatorID = userID
        self.id = id
        self.dateCreated = dateCreated
        self.imageUrl = imageUrl
    }
    
    var fieldsDict: [String: Any] {
        return [
            "imageUrl": self.imageUrl,
            "creatorID": self.creatorID
        ]
    }  
}
