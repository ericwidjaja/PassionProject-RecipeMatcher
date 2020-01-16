//  Favorite.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/1/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation
import FirebaseFirestore

struct Favorite {
    let id: String?
    let label: String
    let imageUrl: String?
    let creatorID: String
    let dateCreated: Date?
    
    //create locally
    init(imageUrl: String? = nil, creatorID: String, dateCreated: Date? = nil, recipeTitle: String) {
        self.imageUrl = imageUrl
        self.creatorID = creatorID
        self.dateCreated = dateCreated
        self.id = UUID().description
        self.label = recipeTitle
    }
    //create remotely
    init?(from dict: [String: Any], id: String) {
        guard let userID = dict["creatorID"] as? String,
            let recipeTitle = dict["recipeTitle"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
            let imageUrl = dict["imageUrl"] as? String else { return nil}
        self.creatorID = userID
        self.label = recipeTitle
        self.id = id
        self.dateCreated = dateCreated
        self.imageUrl = imageUrl
    }
    
    var fieldsDict: [String: Any] {
        return [
            "imageUrl": self.imageUrl as Any,
            "creatorID": self.creatorID,
            "recipeTitle": self.label
        ]
    }  
}
